resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.immutable ? "IMMUTABLE" : "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = merge(
    {
      "Name" = "${local.prefix}-${var.repository_name}"
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
