output "eks_access_entry_arns" {
  description = "Map of created EKS access entries with the keys being the EKS cluster name."
  value = tomap({
    for i, access_entry in aws_eks_access_entry.this : access_entry.cluster_name => access_entry.access_entry_arn
  })
}

output "eks_cluster_arn" {
  description = "ARN of the created EKS cluster."
  value       = length(keys(var.eks_cluster)) > 0 ? aws_eks_cluster.this[0].arn : null
}

output "eks_cluster_endpoint" {
  description = "Kubernetes endpoint of the created EKS cluster."
  value       = length(keys(var.eks_cluster)) > 0 ? aws_eks_cluster.this[0].endpoint : null
  sensitive   = true
}

output "eks_node_group_arn" {
  description = "ARN of the created EKS node group."
  value       = length(keys(var.eks_node_group)) > 0 ? aws_eks_node_group.this[0].arn : null
}
