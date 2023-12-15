data "aws_iam_policy_document" "cloudwatch_access_kms_policy" {
  statement {
    sid    = "AllowCloudWatchToPublishMessageToEncryptedSNS"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]
    resources = ["*"]
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
  }
}

module "sns" {
  source  = "oozou/sns/aws"
  version = "1.0.1"

  prefix      = "oozou"
  environment = "dev"
  name        = "demo-alerting"

  sns_permission_configuration = {
    allow_eventbridge_to_publish_alert = {
      pricipal = "events.amazonaws.com"
    }
  }

  subscription_configurations = {
    oozou_admin = {
      protocol  = "email"
      addresses = ["big@oozou.com"]
    }
  }

  additional_kms_key_policies = [data.aws_iam_policy_document.cloudwatch_access_kms_policy.json]

  tags = { "Workspace" : "Demo" }
}

module "ecr" {
  source = "../.."

  prefix      = "oozou"
  environment = "dev"
  name        = "demo-ecr"

  pull_access_principal_arns      = ["arn:aws:iam::xxxx:group/readonly-dev"]
  push_pull_access_principal_arns = ["arn:aws:iam::xxxx:group/developer-dev"]

  scan_on_push                = true
  cloudwatch_event_target_arn = module.sns.sns_topic_arn
  severity_alert_options      = ["critical", "high", "medium", "low", "informational", "undefined"]
  is_create_lifecycle_policy  = true
  repository_lifecycle_policy = <<EOF
  {
      "rules": [
          {
              "rulePriority": 1,
              "description": "Expire untagged images older than 14 days",
              "selection": {
                  "tagStatus": "any",
                  "countType": "sinceImagePushed",
                  "countUnit": "days",
                  "countNumber": 14
              },
              "action": {
                  "type": "expire"
              }
          }
      ]
  }
  EOF

  # Security
  encryption_configuration = {
    encryption_type = "KMS"
    kms_key         = null
  }

  tags = { "Workspace" : "Demo" }
}
