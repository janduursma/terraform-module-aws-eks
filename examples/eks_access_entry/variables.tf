variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "demo"
}

variable "create_demo_role" {
  description = "Create a temporary IAM role to demonstrate the creation of aws_eks_access_entry."
  type        = bool
  default     = true
}

variable "kubernetes_groups" {
  description = "List of string which can optionally specify the Kubernetes groups the user would belong to when creating an access entry."
  type        = any
  default     = []
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = any
  default     = {}
}

variable "type" {
  description = "Defaults to STANDARD which provides the standard workflow."
  type        = string
  default     = "STANDARD"
}

variable "user_name" {
  description = "Defaults to principal ARN if user is principal else defaults to assume-role/session-name is role is used."
  type        = string
  default     = null
}
