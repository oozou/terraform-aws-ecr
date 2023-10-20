output "repository_arn" {
  value       = module.ecr.repository_arn
  description = "Registry arn"
}

output "repository_url" {
  value       = module.ecr.repository_url
  description = "Repository URL"
}

output "image_name" {
  value       = module.ecr.image_name
  description = "Registry name"
}
