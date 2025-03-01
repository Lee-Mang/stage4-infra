
variable "do_server_size" {
  type        = string
  description = "Size of the server droplet"
}

variable "do_server_image" {
  type        = string
  description = "Image to use for the server droplet"
}

variable "do_region" {
  type        = string
  description = "DigitalOcean region for the droplets"
}

variable "ssh_port" {
  type        = number
  description = "SSH port for the server"
  validation {
    condition     = var.ssh_port >= var.ssh_port_range.min && var.ssh_port <= var.ssh_port_range.max
    error_message = "SSH port must be between ${var.ssh_port_range.min} and ${var.ssh_port_range.max}."
  }
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., prod, staging, dev)"
}

variable "ssh_port_range" {
  type = object({
    min = number
    max = number
  })
  description = "Valid range for SSH ports"
  default = {
    min = 1024
    max = 49151
  }
}
