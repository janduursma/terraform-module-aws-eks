output "eks_node_group_arn" {
  description = "ARN of the created EKS node group."
  value       = one(module.eks_node_group.eks_node_group_arn)
}
