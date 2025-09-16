module "eks_access_entry" {
  source = "../../"

  eks_access_entries = [{
    cluster_name      = var.cluster_name
    kubernetes_groups = var.kubernetes_groups
    principal_arn     = local.example_principal_arn
    region            = var.region
    tags              = var.tags
    type              = var.type
    user_name         = var.user_name
  }]
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
  name_prefix = "eks-access-entry-demo-"
}
