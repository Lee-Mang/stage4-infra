module "compute" {
  source = "../../../modules/digitalocean/compute"

  environment     = var.environment
  do_server_size  = var.do_server_size
  do_server_image = var.do_server_image
  do_region       = var.do_region
  ssh_port        = var.ssh_port
  ssh_port_range  = var.ssh_port_range
}

module "networking" {
  source = "../../../modules/digitalocean/networking"

  environment    = var.environment
  do_region      = var.do_region
  ssh_port       = var.ssh_port
  ssh_port_range = var.ssh_port_range
  server_id      = module.compute.server_id
}

module "project" {
  source = "../../../modules/digitalocean/project"

  environment         = var.environment
  project_name        = var.project_name
  project_description = var.project_description
  project_purpose     = var.project_purpose
  resources = [
    "do:droplet:${module.compute.server_id}",
  ]
}

module "dns" {
  source = "../../../modules/cloudflare/dns"

  environment        = var.environment
  cloudflare_zone_id = var.cloudflare_zone_id
  domain             = var.domain
  server_ipv4        = module.compute.server_ipv4
  subdomains         = var.subdomains
}
