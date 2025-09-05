resource "aws_vpc" "this" {
cidr_block = local.vpc_cidr
enable_dns_hostnames = true
enable_dns_support = true
tags = merge(local.tags, { Name = "${var.cluster_name}-vpc" })
}


resource "aws_internet_gateway" "this" {
vpc_id = aws_vpc.this.id
tags = merge(local.tags, { Name = "${var.cluster_name}-igw" })
}


resource "aws_route_table" "public" {
vpc_id = aws_vpc.this.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.this.id
}
tags = merge(local.tags, { Name = "${var.cluster_name}-public-rt" })
}


resource "aws_subnet" "public" {
count = 2
vpc_id = aws_vpc.this.id
cidr_block = local.subnet_cidrs[count.index]
availability_zone = local.azs[count.index]
map_public_ip_on_launch = true
tags = merge(local.tags, {
Name = "${var.cluster_name}-public-${count.index + 1}"
"kubernetes.io/role/elb" = "1" # allows public load balancers
"kubernetes.io/cluster/${var.cluster_name}" = "shared"
})
}


resource "aws_route_table_association" "public" {
count = 2
route_table_id = aws_route_table.public.id
subnet_id = aws_subnet.public[count.index].id
}