variable "addon_name" {
  description = "Name of the EKS add-on."
  type        = string
  default     = "coredns"
}

variable "addon_version" {
  description = "The version of the EKS add-on. "
  type        = string
  default     = "v1.10.1-eksbuild.1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "demo"
}

variable "configuration_values" {
  description = "Custom configuration values for addons."
  type        = any
  default = {
    replicaCount = 4
    resources = {
      limits = {
        cpu    = "100m"
        memory = "150Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "150Mi"
      }
    }
  }
}

variable "preserve" {
  description = "Indicates if you want to preserve the created resources when deleting the EKS add-on."
  type        = bool
  default     = null
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "resolve_conflicts_on_create" {
  description = "Valid values are NONE and OVERWRITE."
  type        = string
  default     = null
}

variable "resolve_conflicts_on_update" {
  description = "Valid values are NONE, OVERWRITE, and PRESERVE."
  type        = string
  default     = null
}

variable "service_account_role_arn" {
  description = "The Amazon Resource Name (ARN) of an existing IAM role to bind to the add-on's service account."
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = any
  default     = {}
}
