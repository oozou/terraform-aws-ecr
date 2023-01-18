output "repository_url" {
  description = "URL for the ecr repository"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "ARN for the ecr repository"
  value       = aws_ecr_repository.this.arn
}

output "image_name" {
  description = "Name of the ecr image"
  value       = aws_ecr_repository.this.name
}

output "aws_cloudwatch_event_rule_id" {
  description = "The name of the rule"
  value       = try(module.scan_eventbridge[0].aws_cloudwatch_event_rule_id, "")
}

output "aws_cloudwatch_event_rule_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = try(module.scan_eventbridge[0].aws_cloudwatch_event_rule_arn, "")
}
