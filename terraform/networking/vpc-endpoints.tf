resource "aws_security_group" "ecs_tasks" {
  name        = "${var.name_prefix}-ecs-task"
  description = "vpc link security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = var.container_port
    to_port     = var.container_port
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    cidr_blocks = [var.vpc_cidr]
  }

/*
  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [
      aws_vpc_endpoint.s3.prefix_list_id
    ]
  }
*/

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.private.id]
  security_group_ids  = [
    aws_security_group.ecs_tasks.id,
  ]

  tags = {
    Name = "${var.name_prefix}-ecr"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.private.id]
  security_group_ids = [
    aws_security_group.ecs_tasks.id,
  ]
  tags = {
    Name = "${var.name_prefix}-logs"
  }
}

// TODO: This is required. Images in ECR are stored in s3 (? needs double check)
/*
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = ["rtb-0618565988622142e"]

  tags = {
    Name = "${var.name_prefix}-s3"
  }
}
*/
