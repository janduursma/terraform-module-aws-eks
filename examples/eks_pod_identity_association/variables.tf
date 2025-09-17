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

variable "disable_session_tags" {
  description = "Disable the tags that are automatically added to role session by EKS."
  type        = bool
  default     = false
}

variable "namespace" {
  description = "The name of the Kubernetes namespace inside the cluster to create the association in."
  type        = string
  default     = ""
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "role_arn" {
  description = "The ARN of the IAM role to associate with the service account."
  type        = string
  default     = null
}

variable "service_account" {
  description = "The name of the Kubernetes service account inside the cluster to associate the IAM credentials with."
  type        = string
  default     = "demo-sa"
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = any
  default     = {}
}

variable "target_role_arn" {
  description = "The ARN of the IAM role to be chained to the the IAM role specified as role_arn"
  type        = string
  default     = null
}
