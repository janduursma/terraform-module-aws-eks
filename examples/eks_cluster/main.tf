module "eks_cluster" {
  source = "../../"

  eks_cluster = {
    access_config                 = var.access_config
    bootstrap_self_managed_addons = var.bootstrap_self_managed_addons
    compute_config                = var.compute_config
    deletion_protection           = var.deletion_protection
    enabled_cluster_log_types     = var.enabled_cluster_log_types
    encryption_config             = local.effective_encryption_config
    force_update_version          = var.force_update_version
    kubernetes_network_config     = var.kubernetes_network_config
    name                          = var.name
    outpost_config                = var.outpost_config
    region                        = var.region
    remote_network_config         = var.remote_network_config
    role_arn                      = local.effective_cluster_role_arn
    storage_config                = var.storage_config
    tags                          = var.tags
    upgrade_policy                = var.upgrade_policy
    version                       = var.kubernetes_version
    vpc_config                    = local.effective_vpc_config
    zonal_shift_config            = var.zonal_shift_config
  }
}

resource "aws_iam_role" "cluster" {
  count = var.create_demo_roles && var.role_arn == null ? 1 : 0

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "eks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
  name_prefix = "eks-"
}

resource "aws_iam_role_policy_attachment" "cluster_eks_policy" {
  count = length(aws_iam_role.cluster) == 0 ? 0 : 1

  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster[0].name
}

resource "aws_iam_role" "node" {
  count = var.create_demo_roles && try(var.compute_config.enabled, false) ? 1 : 0

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
  name_prefix = "eks-node-"
}

resource "aws_iam_role_policy_attachment" "node_minimal" {
  count = length(aws_iam_role.node) == 0 ? 0 : 1

  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
  role       = aws_iam_role.node[0].name
}

resource "aws_iam_role_policy_attachment" "node_ecr_pull" {
  count = length(aws_iam_role.node) == 0 ? 0 : 1

  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
  role       = aws_iam_role.node[0].name
}

resource "aws_kms_key" "eks_demo" {
  count = var.enable_demo_kms && try(var.encryption_config.provider.key_arn, null) == null ? 1 : 0

  deletion_window_in_days = 7
  description             = "Demo KMS key for EKS secret encryption (examples/eks_cluster)"
  enable_key_rotation     = true
}

resource "aws_kms_alias" "eks_demo" {
  count = length(aws_kms_key.eks_demo)

  name_prefix   = "alias/eks-demo-"
  target_key_id = aws_kms_key.eks_demo[0].key_id
}
