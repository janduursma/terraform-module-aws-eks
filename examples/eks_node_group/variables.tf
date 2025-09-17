variable "ami_type" {
  description = "Type of AMI associated with the EKS node group."
  type        = string
  default     = null
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT."
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

variable "disk_size" {
  description = "Disk size in GiB for worker nodes."
  type        = number
  default     = null
}

variable "force_update_version" {
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  type        = bool
  default     = false
}

variable "instance_types" {
  description = "List of instance types associated with the EKS node group."
  type        = list(string)
  default     = []
}

variable "kubernetes_version" {
  description = "Kubernetes version."
  type        = string
  default     = null
}

variable "labels" {
  description = "Key-value map of Kubernetes labels."
  type        = any
  default     = {}
}

variable "launch_template" {
  description = "Configuration block with Launch Template settings."
  type        = any
  default     = {}
}

variable "node_group_name" {
  description = "Name of the EKS node group."
  type        = string
  default     = null
}

variable "node_group_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix."
  type        = string
  default     = null
}

variable "node_repair_config" {
  description = "The node auto repair configuration for the node group."
  type        = any
  default     = {}
}

variable "region" {
  description = "Region where this resource will be managed."
  type        = string
  default     = "us-west-2"
}

variable "release_version" {
  description = "AMI version of the EKS Node Group."
  type        = string
  default     = null
}

variable "remote_access" {
  description = "Configuration block with remote access settings."
  type        = any
  default     = {}
}

variable "scaling_config" {
  description = "Configuration block with scaling settings."
  type        = any
  default = {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

variable "subnet_ids" {
  description = "Identifiers of EC2 Subnets to associate with the EKS node group."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = any
  default     = {}
}

variable "taints" {
  description = "The Kubernetes taints to be applied to the nodes in the node group."
  type        = any
  default     = []
}

variable "update_config" {
  description = "Configuration block with update settings."
  type        = any
  default     = {}
}
