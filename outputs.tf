output "cluster_endpoint" {
description = "EKS API server endpoint"
value = aws_eks_cluster.this.endpoint
}


output "cluster_name" {
value = aws_eks_cluster.this.name
}


output "cluster_certificate_authority" {
description = "Base64 cluster CA data"
value = aws_eks_cluster.this.certificate_authority[0].data
}


# Optional: A ready-to-save kubeconfig snippet (save to kubeconfig_${var.cluster_name}.yaml if desired)
locals {
kubeconfig_render = yamlencode({
apiVersion = "v1"
clusters = [
{
cluster = {
server = aws_eks_cluster.this.endpoint
certificate-authority-data = aws_eks_cluster.this.certificate_authority[0].data
}
name = aws_eks_cluster.this.name
}
]
contexts = [
{
context = {
cluster = aws_eks_cluster.this.name
user = aws_eks_cluster.this.name
}
name = aws_eks_cluster.this.name
}
]
current-context = aws_eks_cluster.this.name
kind = "Config"
users = [
{
name = aws_eks_cluster.this.name
user = {
exec = {
apiVersion = "client.authentication.k8s.io/v1beta1"
command = "aws"
args = ["eks", "get-token", "--region", var.region, "--cluster-name", aws_eks_cluster.this.name]
}
}
}
]
})
}


output "kubeconfig_yaml" {
description = "Kubeconfig you can save to a file if not using aws eks update-kubeconfig"
value = local.kubeconfig_render
sensitive = true
}