resource "aws_ecr_repository" "this" {
  name                 = local.name
  image_tag_mutability = var.immutable ? "IMMUTABLE" : "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  dynamic "encryption_configuration" {
    for_each = var.encryption_configuration == null ? [] : [var.encryption_configuration]
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key
    }
  }

  tags = merge(
    {
      "Name" = local.name
    },
    local.tags
  )
}

data "aws_iam_policy_document" "allow_access" {
  version = "2008-10-17"
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetAuthorizationToken",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:ListTagsForResource"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    effect = "Allow"
    sid    = "CrossAccountPull"
    condition {
      test     = "ForAnyValue:ArnEquals"
      variable = "aws:PrincipalArn"
      values   = var.pull_access_principal_arns
    }
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    effect = "Allow"
    sid    = "CrossAccountPushAndPull"
    condition {
      test     = "ForAnyValue:ArnEquals"
      variable = "aws:PrincipalArn"
      values   = var.push_pull_access_principal_arns
    }
  }
}

resource "aws_ecr_repository_policy" "allow_access" {
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.allow_access.json
}

/* -------------------------------------------------------------------------- */
/*                                 EventBridge                                */
/* -------------------------------------------------------------------------- */
module "scan_eventbridge" {
  count = var.scan_on_push && length(var.severity_alert_options) > 0 ? 1 : 0

  source = "git@github.com:oozou/terraform-aws-eventbridge.git?ref=feat/support-multiple-target"

  prefix      = var.prefix
  environment = var.environment
  name        = var.name

  event_pattern               = local.event_pattern
  cloudwatch_event_target_arn = var.cloudwatch_event_target_arn
  input_transformer = {
    input_paths = {
      "image" : "$.detail.repository-name",
      "critical" : "$.detail.finding-severity-counts.CRITICAL",
      "high" : "$.detail.finding-severity-counts.HIGH",
      "medium" : "$.detail.finding-severity-counts.MEDIUM",
      "low" : "$.detail.finding-severity-counts.LOW",
      "informational" : "$.detail.finding-severity-counts.INFORMATIONAL",
      "undefined" : "$.detail.finding-severity-counts.UNDEFINED"
    }
    # In the AWS console you have to include the quotes around your string too
    # Issue: https://github.com/terraform-providers/terraform-provider-aws/issues/7280#issuecomment-585938344
    input_template = "\"Alert: ECR image scanning failed for image <image>. Vulnerability severity counts are Critical: <critical>, High: <high>, Medium: <medium>, Low: <low>, Informational: <informational>, Undefined: <undefined>. Please check the ECR console to mitigate the findings.\""
  }

  tags = local.tags
}
