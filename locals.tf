locals {
  name = format("%s-%s-%s", var.prefix, var.environment, var.name)

  pre_event_pattern = jsondecode(templatefile("${path.module}/templates/scan_event_pattern.json", { ecr_arn = aws_ecr_repository.this.arn }))
  greater_than_zero_pattern = [
    {
      "exists" = true
    }
  ]
  severity_alert_options = {
    "detail" : {
      "finding-severity-counts" : { for value in var.severity_alert_options : upper(value) => local.greater_than_zero_pattern }
    }
  }
  event_pattern = jsonencode(merge(local.pre_event_pattern, local.severity_alert_options))

  tags = merge(
    {
      "Environment" = var.environment,
      "Terraform"   = "true"
    },
    var.tags,
  )
}
