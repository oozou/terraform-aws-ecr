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
