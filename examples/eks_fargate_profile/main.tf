module "eks_fargate_profile" {
  source = "../../"

  eks_fargate_profiles = [{
    cluster_name           = var.cluster_name
    fargate_profile_name   = var.fargate_profile_name
    pod_execution_role_arn = local.example_iam_role_arn
    selector               = var.selector
    subnet_ids             = local.effective_subnet_ids
    region                 = var.region
    tags                   = var.tags
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
  name_prefix = "eks-fargate-profile-demo-"
}
