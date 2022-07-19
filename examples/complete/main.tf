module "ecr" {
  source = "../.."

  # Generics
  repository_name = "sample-test-repo"
  prefix          = "oozou"
  environment     = "dev"

  tags = {
    "test" : "example-tag"
  }

  # Access
  pull_access_principal_arns = ["arn:aws:iam::562563527952:group/readonly-dev"]
  push_pull_access_principal_arns = ["arn:aws:iam::562563527952:group/developer-dev"]

  # Security
  immutable = true
  scan_on_push = true
  encryption_configuration = {
    encryption_type = "KMS"
    kms_key         = null
  }

}