# Ansible configuration
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    server_ip = module.compute.server_ipv4
  })
  filename = "../../../ansible/inventory.ini"
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    working_dir = "../../../ansible"
    command     = <<-EOT
      ansible-playbook playbook.yml
    EOT
  }

  depends_on = [
    module.compute,
    local_file.ansible_inventory
  ]
}
