variable "prefix" {
  description = "The prefix name of customer to be displayed in AWS console and resource"
  type        = string
}

variable "repository_name" {
  description = "Name of the repository (pass + micro service name)"
  type        = string
}

variable "environment" {
  description = "To manage a resources with tags"
  type        = string
}

variable "tags" {
  description = "Tag for a resource taht create by this component"
  type        = map(string)
  default     = {}
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}

variable "immutable" {
  description = "The tag mutability setting for the repository"
  type        = bool
  default     = false
}

variable "pull_access_principal_arns" {
  description = "Principals to set to the repository policy to gain Pull access to the repo"
  type        = list(string)
  default     = []
}

variable "push_pull_access_principal_arns" {
  description = "Principals to set to the repository policy to gain Push and Pull access to the repo"
  type        = list(string)
  default     = []
}