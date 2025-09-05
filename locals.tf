# Pick the first two AZs in the region for simplicity
data "aws_availability_zones" "available" { state = "available" }


locals {
azs = slice(data.aws_availability_zones.available.names, 0, 2)
vpc_cidr = "10.0.0.0/16"
subnet_cidrs = [
"10.0.1.0/24",
"10.0.2.0/24",
]
tags = {
Project = var.cluster_name
Managed = "terraform"
}
}