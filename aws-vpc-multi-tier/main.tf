resource "aws_vpc" "vpc-tf" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.true
  enable_dns_hostnames = var.true

  tags = {
    Name = "tf-vpc"
  }
}

data "aws_availability_zones" "available-azs" {
  state = "available"
}

resource "aws_subnet" "public-subnet-tf" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc-tf.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available-azs.names)[each.value - 1]
  map_public_ip_on_launch = var.true

  tags = {
    Name = "tf-subnet-public-${each.value}"
    Tier = "Public"
  }
}

resource "aws_subnet" "private-subnet-tf" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.vpc-tf.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone       = tolist(data.aws_availability_zones.available-azs.names)[each.value - 1]
  map_public_ip_on_launch = var.false

  tags = {
    Name = "tf-subnet-private-${each.value}"
    Tier = "Private"
  }
}