module "eks_node_group" {
  source = "../../"

  eks_node_group = {
    ami_type               = var.ami_type
    capacity_type          = var.capacity_type
    cluster_name           = var.cluster_name
    disk_size              = var.disk_size
    force_update_version   = var.force_update_version
    instance_types         = var.instance_types
    labels                 = var.labels
    launch_template        = var.launch_template
    node_group_name_prefix = var.node_group_name_prefix
    node_group_name        = var.node_group_name
    node_repair_config     = var.node_repair_config
    node_role_arn          = local.example_iam_role_arn
    region                 = var.region
    release_version        = var.release_version
    remote_access          = var.remote_access
    scaling_config         = var.scaling_config
    subnet_ids             = local.effective_subnet_ids
    tags                   = var.tags
    taint                  = var.taints
    update_config          = var.update_config
    version                = var.kubernetes_version
  }
}

resource "aws_iam_role" "demo" {
  count = var.create_demo_role ? 1 : 0

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRole",
      Principal = { AWS = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root" }
    }]
  })
  name_prefix = "eks-node-group-demo"
}
