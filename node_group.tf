resource "aws_eks_node_group" "default" {
cluster_name = aws_eks_cluster.this.name
node_group_name = "default"
node_role_arn = aws_iam_role.eks_node.arn
subnet_ids = [for s in aws_subnet.public : s.id]


scaling_config {
desired_size = 2
max_size = 2
min_size = 2
}


ami_type = "AL2_x86_64"
capacity_type = "ON_DEMAND"
instance_types = ["t2.micro"]


tags = local.tags


depends_on = [
aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
]
}