module "eks_pod_identity_association" {
  source = "../../"

  eks_pod_identity_associations = [{
    cluster_name    = var.cluster_name
    namespace       = var.namespace
    role_arn        = local.effective_role_arn
    service_account = var.service_account

    disable_session_tags = var.disable_session_tags
    region               = var.region
    tags                 = var.tags
    target_role_arn      = var.target_role_arn
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
