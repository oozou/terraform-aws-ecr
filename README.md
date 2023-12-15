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

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 3.63  |

## Providers

| Name                                              | Version |
|---------------------------------------------------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.1  |

## Modules

No modules.

## Resources

| Name                                                                                                                                        | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)                       | resource    |
| [aws_ecr_repository_policy.allow_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource    |
| [aws_iam_policy_document.allow_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)  | data source |

## Inputs

| Name                                                                                                                                    | Description                                                                         | Type           | Default | Required |
|-----------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|----------------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment)                                                                     | To manage a resources with tags                                                     | `string`       | n/a     |   yes    |
| <a name="input_immutable"></a> [immutable](#input\_immutable)                                                                           | The tag mutability setting for the repository                                       | `bool`         | `false` |    no    |
| <a name="input_pull_access_principal_arns"></a> [pull\_access\_principal\_arns](#input\_pull\_access\_principal\_arns)                  | Principals to set to the repository policy to gain Pull access to the repo          | `list(string)` | `[]`    |    no    |
| <a name="input_push_pull_access_principal_arns"></a> [push\_pull\_access\_principal\_arns](#input\_push\_pull\_access\_principal\_arns) | Principals to set to the repository policy to gain Push and Pull access to the repo | `list(string)` | `[]`    |    no    |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name)                                                       | Name of the repository                                                              | `string`       | n/a     |   yes    |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push)                                                              | Indicates whether images are scanned after being pushed to the repository           | `bool`         | `true`  |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                          | Tag for a resource taht create by this component                                    | `map(string)`  | `{}`    |    no    |

## Outputs

| Name                                                                             | Description                |
|----------------------------------------------------------------------------------|----------------------------|
| <a name="output_image_name"></a> [image\_name](#output\_image\_name)             | Name of the ecr image      |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | ARN for the ecr repository |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | URL for the ecr repository |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_scan_eventbridge"></a> [scan\_eventbridge](#module\_scan\_eventbridge) | oozou/eventbridge/aws | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.allow_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.allow_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_event_target_arn"></a> [cloudwatch\_event\_target\_arn](#input\_cloudwatch\_event\_target\_arn) | The Amazon Resource Name (ARN) associated of the target. | `string` | `""` | no |
| <a name="input_encryption_configuration"></a> [encryption\_configuration](#input\_encryption\_configuration) | ECR encryption configuration | <pre>object({<br>    encryption_type = string<br>    kms_key         = any<br>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | To manage a resources with tags | `string` | n/a | yes |
| <a name="input_immutable"></a> [immutable](#input\_immutable) | The tag mutability setting for the repository | `bool` | `false` | no |
| <a name="input_is_create_lifecycle_policy"></a> [is\_create\_lifecycle\_policy](#input\_is\_create\_lifecycle\_policy) | Determines whether a lifecycle policy will be created | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository (pass + micro service name) | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix name of customer to be displayed in AWS console and resource | `string` | n/a | yes |
| <a name="input_pull_access_principal_arns"></a> [pull\_access\_principal\_arns](#input\_pull\_access\_principal\_arns) | Principals to set to the repository policy to gain Pull access to the repo | `list(string)` | `[]` | no |
| <a name="input_push_pull_access_principal_arns"></a> [push\_pull\_access\_principal\_arns](#input\_push\_pull\_access\_principal\_arns) | Principals to set to the repository policy to gain Push and Pull access to the repo | `list(string)` | `[]` | no |
| <a name="input_repository_lifecycle_policy"></a> [repository\_lifecycle\_policy](#input\_repository\_lifecycle\_policy) | The policy document. This is a JSON formatted string. See more details about [Policy Parameters](http://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html#lifecycle_policy_parameters) in the official AWS docs | `string` | `""` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Indicates whether images are scanned after being pushed to the repository | `bool` | `true` | no |
| <a name="input_severity_alert_options"></a> [severity\_alert\_options](#input\_severity\_alert\_options) | (Optional) Choose alerting options | `list(string)` | <pre>[<br>  "critical",<br>  "high",<br>  "medium"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag for a resource taht create by this component | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cloudwatch_event_rule_arn"></a> [aws\_cloudwatch\_event\_rule\_arn](#output\_aws\_cloudwatch\_event\_rule\_arn) | The Amazon Resource Name (ARN) of the rule. |
| <a name="output_aws_cloudwatch_event_rule_id"></a> [aws\_cloudwatch\_event\_rule\_id](#output\_aws\_cloudwatch\_event\_rule\_id) | The name of the rule |
| <a name="output_image_name"></a> [image\_name](#output\_image\_name) | Name of the ecr image |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | ARN for the ecr repository |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | URL for the ecr repository |
<!-- END_TF_DOCS -->
