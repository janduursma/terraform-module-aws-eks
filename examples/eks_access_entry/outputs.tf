output "eks_cluster_access_entry_arns" {
  description = "ARN of the created EKS access entry."
  value       = one(module.eks_access_entry.eks_access_entry_arns[*])
}
