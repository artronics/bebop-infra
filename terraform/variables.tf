variable "project" {
  default = "bebop"
}

variable "domain_name" {
  default = "dev.api.platform.nhs.uk"
}

variable "environments" {
  default = ["dev"]
}

variable "service" {
  default = "infra"
}

locals {
  environment = terraform.workspace
}
