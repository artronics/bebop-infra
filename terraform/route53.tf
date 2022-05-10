data "aws_route53_zone" "account_zone_id" {
  name = var.domain_name
}
