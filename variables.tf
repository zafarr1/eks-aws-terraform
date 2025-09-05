variable "region" {
description = "AWS region to deploy to"
type = string
default = "us-east-1"
}


variable "cluster_name" {
description = "EKS cluster name"
type = string
default = "demo-eks"
}


variable "kubernetes_version" {
description = "Kubernetes version for EKS"
type = string
default = "1.29"
}