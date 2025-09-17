variable "access_scope_type" {
  description = "Valid values are namespace or cluster."
  type        = string
  default     = "cluster"
}

variable "access_scope_namespace" {
  description = "The namespaces to which the access scope applies when type is namespace."
  type        = string
  default     = null
}

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

variable "policy_name" {
  description = "The name of the access policy that you're associating."
  type        = string
  default     = "AmazonEKSClusterAdminPolicy"
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "role_arn" {
  description = "The IAM role ARN which requires authentication access to the EKS cluster."
  type        = string
  default     = null
}
