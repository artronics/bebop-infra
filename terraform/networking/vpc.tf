locals {
  vpc_cidr = "10.0.0.0/16"
}

resource "aws_vpc" "bebop_dev_vpc" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = "bebop-dev"
  }
}
