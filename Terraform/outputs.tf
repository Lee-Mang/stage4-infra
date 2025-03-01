output "server_ipv4" {
  value       = digitalocean_droplet.server.ipv4_address
  description = "IPv4 address of the server droplet"
}

