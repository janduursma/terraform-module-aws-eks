output "eks_cluster_arn" {
  description = "ARN of the created EKS cluster."
  value       = one(module.eks_cluster.eks_cluster_arn)
}

output "eks_endpoint" {
  description = "Endpoint of the created EKS cluster."
  value       = one(module.eks_cluster.eks_cluster_endpoint)
}
