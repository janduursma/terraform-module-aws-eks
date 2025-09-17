locals {
  effective_cluster_role_arn = coalesce(
    var.role_arn,
    try(aws_iam_role.cluster[0].arn, null)
  )

  _user_encryption_configs = (
    try(var.encryption_config.provider.key_arn, null) != null
    ? [var.encryption_config]
    : []
  )
  _demo_encryption_configs = (
    length(aws_kms_key.eks_demo) > 0
    ? [{
      provider  = { key_arn = aws_kms_key.eks_demo[0].arn }
      resources = ["secrets"]
    }]
    : []
  )
  _encryption_candidates      = concat(local._user_encryption_configs, local._demo_encryption_configs)
  effective_encryption_config = try(local._encryption_candidates[0], {})

  effective_vpc_config = merge(
    var.vpc_config,
    {
      security_group_ids = coalesce(
        try(var.vpc_config.security_group_ids, null),
        try([data.aws_security_group.default_vpc_sg.id], [])
      )
      subnet_ids = coalesce(
        try(var.vpc_config.subnet_ids, null),
        try(data.aws_subnets.default.ids, [])
      )
    }
  )
}
