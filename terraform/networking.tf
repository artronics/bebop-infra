module "networking" {
  source = "./networking"
  name_prefix = "bebop-dev"
  container_port = 9000
}
