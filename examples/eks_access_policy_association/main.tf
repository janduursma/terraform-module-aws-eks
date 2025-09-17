module "eks_addon" {
  source = "../../"

  eks_access_policy_associations = [{
    access_scope = {
      type      = var.access_scope_type
      namespace = var.access_scope_namespace
    }
    cluster_name  = var.cluster_name
    policy_arn    = local.policy_arn
    principal_arn = local.effective_role_arn
    region        = var.region
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
  name_prefix = "eks-access-assoc-demo-"
}
