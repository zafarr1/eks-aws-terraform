resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.kubernetes_version


  vpc_config {
    subnet_ids              = [for s in aws_subnet.public : s.id]
    endpoint_private_access = false
    endpoint_public_access  = true
  }


  tags = local.tags


  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceController,
  ]
}