data "aws_availability_zones" "available"{}

resource "aws_vpc" "devVPC" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
  Name = "dev_terraform_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.devVPC.id
  cidr_block = var.public_cidr
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "dev_terraform_vpc_public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.devVPC.id
  cidr_block = var.private_cidr
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "dev_terraform_vpc_private_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devVPC.id
  tags = {
    Name = "dev_terraform_vpc_igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.devVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "dev_terraform_vpc_public_route"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.public_route.id
  subnet_id = aws_subnet.public_subnet.id
  depends_on = [aws_route_table.public_route, aws_subnet.public_subnet]
}