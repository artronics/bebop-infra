locals {
  private_subnet_cidr = "10.0.1.0/24"
  public_subnet_cidr = "10.0.2.0/24"
}
resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = local.private_subnet_cidr

  tags = {
    Name = "${var.name_prefix}-private-subnet-a"
  }
}

output "private_subnet" {
  value = aws_subnet.private.id
}

resource "aws_subnet" "public" {
  vpc_id     = var.vpc_id
  cidr_block = local.public_subnet_cidr
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.name_prefix}-public-subnet-a"
  }
}

output "public_subnet" {
  value = aws_subnet.public.id
}

// This is for public subnet
resource "aws_internet_gateway" "igw" {
vpc_id = var.vpc_id
  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.name_prefix}-rt"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public.id
}
