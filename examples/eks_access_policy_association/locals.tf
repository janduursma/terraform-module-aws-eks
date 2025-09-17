locals {
  current_iam_role_arn = replace(
    data.aws_caller_identity.current.arn,
    "arn:${data.aws_partition.current.partition}:sts::${data.aws_caller_identity.current.account_id}:assumed-role/",
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/"
  )

  effective_role_arn = coalesce(
    var.role_arn,
    try(one(aws_iam_role.demo[*].arn), null),
    local.current_iam_role_arn
  )

  policy_arn = "arn:${data.aws_partition.current.partition}:eks::aws:cluster-access-policy/${var.policy_name}"
}
