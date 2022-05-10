locals {
  projects = [
    {
      name = "barz"
    }
  ]
}

module "projects" {
  source = "./projects"
  count = length(local.projects)

  account_zone_id = data.aws_route53_zone.account_zone_id.zone_id
  environments = var.environments

  project = local.projects[count.index]

}

output "projects_zone" {
  value = module.projects
}
