# A VPC for Infra Creation
resource "aws_vpc" "aws_vpc" {
    cidr_block = var.aws_vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true  

}

# Internet gateways
# Design internet gateway for internet access

resource "aws_internet_gateway" "aws_internet_gateway" {
    vpc_id = aws_vpc.aws_vpc.id

}

# Subnets in VPC
# Subnets
# Disbale setting public ipv4 on 2 subnets(if creating 4 subnets, 2 private, 2 public)

resource "aws_subnet" "private_aws_subnet"{
    count = 2
    vpc_id = aws_vpc.aws_vpc.id
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[count.index]
    cidr_block = var.private_aws_subnet_ranges[count.index]
    tags = {
      "Name" = "private"
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/demo" = "owned"
    }
}
resource "aws_subnet" "public_aws_subnet"{
    count = 2
    vpc_id = aws_vpc.aws_vpc.id
    availability_zone = data.aws_availability_zones.aws_availability_zones.names[count.index]
    cidr_block = var.public_aws_subnet_ranges[count.index]
    tags = {
      "Name" = "public"
      "kubernetes.io/role/internal-elb" = "1"
      "kubernetes.io/cluster/demo" = "owned"
    }
}

# NAT gateway for internet access on nodegroup

resource "aws_eip" "nat" {
    count = 2
    vpc = true
    tags = {
      
      "Name" = "NAT_publicip"
    }
  
}
resource "aws_nat_gateway" "aws_nat_gateway" {
    count = 2
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = aws_subnet.public_aws_subnet[count.index].id
    depends_on = [aws_internet_gateway.aws_internet_gateway]
  
}

# Route tables for public subnets(NAT Gateway) to Internet gateway,and private subnets to NAT Gateway,this separates private and public subnets
resource "aws_route_table" "private_route_table" {
    count = 2
    vpc_id = aws_vpc.aws_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.aws_nat_gateway[count.index].id
    }
    
}
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.aws_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.aws_internet_gateway.id
    }
}

resource "aws_route_table_association" "private_routes" {
    count = 2
    subnet_id = aws_subnet.private_aws_subnet[count.index].id
    route_table_id = aws_route_table.private_route_table[count.index].id
  
}
resource "aws_route_table_association" "public_routes" {
    count = 2
    subnet_id = aws_subnet.public_aws_subnet[count.index].id
    route_table_id = aws_route_table.public_route_table.id
  
}

# Start Building EKS cluster
# module "eks_cluster_module" {
#    source = "../terraform_eks"
#}

module "ec2_module" {
    source = "../terraform_ec2"
    subnet_id = aws_subnet.private_aws_subnet[0].id
    vpcid = aws_vpc.aws_vpc.id
  
}