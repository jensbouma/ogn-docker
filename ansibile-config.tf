output "tf_ansible_vars_file" {
  value = <<-DOC
    # Cloudflared Tunnel Settings
    tunnel_id: ${cloudflare_tunnel.auto_tunnel.id}
    account: ${var.cloudflare_account_id}
    tunnel_name: ${cloudflare_tunnel.auto_tunnel.name}
    secret: ${base64sha256(random_password.tunnel_secret.result)}
    zone: ${local.cloudflare_zone}
    host_name: ${lower(local.receiver_name)}
    DOC
    sensitive = true
}

output "tf_inventory_file_local" {
  value = <<-DOC
    # Ansible hosts file containing the IP address of the Raspberry Pi and username and key file.
    [rpi]
    ${local.rpi_ip} ansible_user=${local.rpi_user} ansible_ssh_private_key_file=${local.privatekey_file}
    DOC
}

output "tf_inventory_file_remote" {
  value = <<-DOC
    # Ansible hosts file containing the IP address of the Raspberry Pi and username and key file.
    [rpi]
    ${cloudflare_record.ssh.hostname} ansible_user=${local.rpi_user} ansible_ssh_private_key_file=${local.privatekey_file}
    DOC
}

output "ssh_tunnel_config" {
  value = <<-DOC
    # SSH tunnel configuration for the Raspberry Pi.
    Host ${lower(local.receiver_name)}-ssh.${local.cloudflare_zone}
    ProxyCommand /opt/homebrew/bin/cloudflared access ssh --hostname %h
    DOC
}
