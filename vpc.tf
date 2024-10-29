resource "aws_vpc" "vpc1" {
  cidr_block           = "10.10.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "created_from_Terraform"
  }
}

resource "aws_subnet" "vpc1-pub-s1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.Zones["a"]
  tags = {
    Name = "vpc1-pub-s1"
  }
}

resource "aws_subnet" "vpc1-pub-s2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.Zones["b"]
  tags = {
    Name = "vpc1-pub-s2"
  }
}

resource "aws_subnet" "vpc1-pub-s3" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.Zones["c"]
  tags = {
    Name = "vpc1-pub-s3"
  }
}

resource "aws_subnet" "vpc1-pvt-s1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.Zones["a"]
  tags = {
    Name = "vpc1-pvt-s1"
  }
}

resource "aws_subnet" "vpc1-pvt-s2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.Zones["b"]
  tags = {
    Name = "vpc1-pvt-s2"
  }
}

resource "aws_subnet" "vpc1-pvt-s3" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.10.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.Zones["c"]
  tags = {
    Name = "vpc1-pvt-s3"
  }
}

resource "aws_internet_gateway" "vpc1-igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "vpc1-Internet-GW"
  }
}

resource "aws_route_table" "vpc1-rt1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1-igw.id
  }
  tags = {
    Name = "vpc1-RouteTable-1"
    for  = "public subnets"
  }
}

resource "aws_route_table_association" "vpc1-rt1-ass1" {
  subnet_id      = aws_subnet.vpc1-pub-s1.id
  route_table_id = aws_route_table.vpc1-rt1.id
}

resource "aws_route_table_association" "vpc1-rt1-ass2" {
  subnet_id      = aws_subnet.vpc1-pub-s2.id
  route_table_id = aws_route_table.vpc1-rt1.id
}

resource "aws_route_table_association" "vpc1-rt1-ass3" {
  subnet_id      = aws_subnet.vpc1-pub-s3.id
  route_table_id = aws_route_table.vpc1-rt1.id
}

