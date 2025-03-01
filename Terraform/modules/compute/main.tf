terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Server droplet
resource "digitalocean_droplet" "server" {
  name   = "${var.environment}-server"
  region = var.do_region
  tags   = ["environment:${var.environment}"]
  size   = var.do_server_size
  image  = var.do_server_image
  user_data = templatefile("${path.module}/templates/userdata.yml", {
    pubkey   = try(file("${path.root}/key.pub"), "")
    ssh_port = var.ssh_port
  })
}
