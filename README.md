# AWS ECR Terraform Module

Terraform module with create ecr and ecr policy resources on AWS.

## Usage

```terraform
module "ecr" {
  source = "git::ssh://git@github.com:oozou/terraform-aws-ecr.git"
  repository_name = "zeus-test-repo"
  environment     = "dev"
  tags = {
    "test" : "example-tag"
  }
  push_pull_access_principal_arns = ["arn:aws:iam::xxx:user/ecr-test-user"]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.allow_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.allow_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | To manage a resources with tags | `string` | n/a | yes |
| <a name="input_immutable"></a> [immutable](#input\_immutable) | The tag mutability setting for the repository | `bool` | `false` | no |
| <a name="input_pull_access_principal_arns"></a> [pull\_access\_principal\_arns](#input\_pull\_access\_principal\_arns) | Principals to set to the repository policy to gain Pull access to the repo | `list(string)` | `[]` | no |
| <a name="input_push_pull_access_principal_arns"></a> [push\_pull\_access\_principal\_arns](#input\_push\_pull\_access\_principal\_arns) | Principals to set to the repository policy to gain Push and Pull access to the repo | `list(string)` | `[]` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of the repository | `string` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Indicates whether images are scanned after being pushed to the repository | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag for a resource taht create by this component | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_name"></a> [image\_name](#output\_image\_name) | Name of the ecr image |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | ARN for the ecr repository |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | URL for the ecr repository |
