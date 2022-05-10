data "aws_route53_zone" "account_zone" {
  zone_id = var.account_zone_id
}

resource "aws_route53_zone" "project_zone" {
  for_each = var.environments
  name     = "${each.key}.${var.project.name}.${data.aws_route53_zone.account_zone.name}"
}

output "project_zone" {
  value = [
  for z in aws_route53_zone.project_zone : z.name
  ]
}
