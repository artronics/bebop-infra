locals {
  vpc_cidr = "10.0.0.0/16"
}

resource "aws_vpc" "bebop_dev_vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "bebop-dev"
  }
}

module "networking" {
  source         = "./networking"
  name_prefix    = "bebop-dev"
  container_port = 9000
  vpc_cidr = local.vpc_cidr
  vpc_id = aws_vpc.bebop_dev_vpc.id
}

output "bebop-dev-vpc_id" {
  value = aws_vpc.bebop_dev_vpc.id
}

output "bebop-dev-private_subnet" {
  value = module.networking.private_subnet
}

output "bebop-dev-public_subnet" {
  value = module.networking.public_subnet
}
