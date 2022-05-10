variable "account_zone_id" {}

variable "environments" {
  type = set(string)
}

variable "project" {
  type = object({
    name = string
  })
}
