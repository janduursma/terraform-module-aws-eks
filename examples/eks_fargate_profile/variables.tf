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

variable "fargate_profile_name" {
  description = "Name of the EKS Fargate Profile."
  type        = string
  default     = "demo"
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "subnet_ids" {
  description = "Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile."
  type        = list(string)
  default     = null
}

variable "selector" {
  description = "Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile."
  type        = any
  default = {
    namespace = "example.com"
  }
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = any
  default     = {}
}
