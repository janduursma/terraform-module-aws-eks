locals {
  current_iam_role_arn = replace(
    data.aws_caller_identity.current.arn,
    "arn:${data.aws_partition.current.partition}:sts::${data.aws_caller_identity.current.account_id}:assumed-role/",
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/"
  )

  example_principal_arn = var.create_demo_role ? one(aws_iam_role.demo[*].arn) : local.current_iam_role_arn
}
