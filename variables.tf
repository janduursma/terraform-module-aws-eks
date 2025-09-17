variable "eks_access_entries" {
  description = "Access entry configurations for an EKS cluster."
  type        = any
  default     = []
}

variable "eks_access_policy_associations" {
  description = "Access entry policy associations for an EKS cluster."
  type        = any
  default     = []
}

variable "eks_addons" {
  description = "Add-ons for an EKS cluster."
  type        = any
  default     = []
}

variable "eks_cluster" {
  description = "Configuration values for an EKS cluster."
  type        = any
  default     = {}
}

variable "eks_fargate_profiles" {
  description = "EKS Fargate profiles."
  type        = any
  default     = []
}

variable "eks_identity_provider_configs" {
  description = "EKS identity providers."
  type        = any
  default     = []
}

variable "eks_node_group" {
  description = "Configuration values for EKS node groups."
  type        = any
  default     = {}
}

variable "eks_pod_identity_associations" {
  description = "EKS pod identity associations."
  type        = any
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = any
  default     = {}
}

