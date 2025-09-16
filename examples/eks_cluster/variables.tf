variable "access_config" {
  description = "Configuration block for the access config associated with your cluster."
  type        = any
  default = {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
}

variable "bootstrap_self_managed_addons" {
  description = "Install default unmanaged add-ons, such as aws-cni, kube-proxy, and CoreDNS during cluster creation. If false, you must manually install desired add-ons."
  type        = bool
  default     = false
}

variable "compute_config" {
  description = "Configuration block with compute configuration for EKS Auto Mode."
  type        = any
  default = {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = null
  }
}

variable "create_demo_roles" {
  description = "Create demo IAM roles for the cluster (control plane) and Auto Mode nodes when ARNs are not provided."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the cluster."
  type        = bool
  default     = true
}

variable "enabled_cluster_log_types" {
  description = "List of the desired control plane logging to enable."
  type        = any
  default     = ["audit"]
}

variable "enable_demo_kms" {
  description = "Create a demo KMS key for the encryption config."
  type        = bool
  default     = true
}

variable "encryption_config" {
  description = "Configuration block with encryption configuration for the cluster."
  type        = any
  default = {
    provider  = { key_arn = null }
    resources = ["secrets"]
  }
}

variable "force_update_version" {
  description = "Force version update by overriding upgrade-blocking readiness checks when updating a cluster."
  type        = bool
  default     = false
}

variable "kubernetes_network_config" {
  description = "Configuration block with kubernetes network configuration for the cluster."
  type        = any
  default = {
    ip_family         = "ipv4"
    service_ipv4_cidr = "172.20.0.0/16"
    elastic_load_balancing = {
      enabled = true
    }
  }
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version."
  type        = string
  default     = "1.31"
}

variable "name" {
  description = "Name of the cluster."
  type        = string
  default     = "demo"
}

variable "outpost_config" {
  description = "Configuration block representing the configuration of your local EKS cluster on an AWS Outpost."
  type        = any
  default     = {}
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "remote_network_config" {
  description = "Configuration block with remote network configuration for EKS Hybrid Nodes."
  type        = any
  default = {
    remote_node_networks = { cidrs = ["172.16.0.0/18"] }
    remote_pod_networks  = { cidrs = ["172.16.64.0/18"] }
  }
}

variable "role_arn" {
  description = "ARN of the IAM role used by the EKS control plane."
  type        = string
  default     = null
}

variable "storage_config" {
  description = "Configuration block with storage configuration for EKS Auto Mode."
  type        = any
  default = {
    block_storage = { enabled = true }
  }
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = any
  default     = {}
}

variable "upgrade_policy" {
  description = "Configuration block for the support policy to use for the cluster."
  type        = any
  default = {
    support_type = "STANDARD"
  }
}

variable "vpc_config" {
  description = "Configuration block for the VPC associated with your cluster."
  type        = any
  default = {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = null
    subnet_ids              = null
  }
}

variable "zonal_shift_config" {
  description = "Configuration block with zonal shift configuration for the cluster."
  type        = any
  default = {
    enabled = false
  }
}


