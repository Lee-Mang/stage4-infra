# main.tf

provider "digitalocean" {
  token = "dop_v1_90b25d425f4e1e6059c670bee45e830521e8fc80cfb4f9853685dac013a68738"
}

resource "digitalocean_droplet" "server" {
  image  = "ubuntu-24-10-x64"
  name   = "ubuntu-HNG"
  region = "lon1"  # Use your preferred region
  size   = "s-1vcpu-2gb"
  ssh_keys = ["HNG"]  # Replace with your SSH key ID
}

output "server_id" {
  value = digitalocean_droplet.server.id
}

output "droplet_ip" {
  value = digitalocean_droplet.server.ipv4_address
}

resource "digitalocean_firewall" "server-firewall" {
  name        = "${var.environment}-server-firewall"
  tags        = ["environment:${var.environment}"]
  droplet_ids = [var.server_id]

  inbound_rule {
    protocol   = "tcp"
    port_range = "22"
    cidr_blocks = ["0.0.0.0/0"]
  }

 inbound_rule {
    protocol    = "tcp"
    port_range  = "80"
    cidr_blocks = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol    = "tcp"
    port_range  = "443"
    cidr_blocks = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

