variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "demo"
}

variable "oidc" {
  description = "Nested attribute containing OpenID Connect identity provider information for the cluster."
  type        = any
  default = {
    client_id                     = "demo"
    identity_provider_config_name = "example"
    issuer_url                    = "https://example.com"
  }
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
