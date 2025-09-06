output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_certificate_authority" {
  description = "Base64 cluster CA data"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}
