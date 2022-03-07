locals {
  prefix = "${var.prefix}-${var.environment}"
  tags = merge(
    {
      "Environment" = var.environment,
      "Terraform"   = "true"
    },
    var.tags,
  )
}