output "kubeone_api" {
  description = "kube-apiserver LB endpoint"

  value = {
    endpoint                    = "${cloudflare_record.dns_api_v4.name}.${var.dns_domain}"
    apiserver_alternative_names = var.apiserver_alternative_names
  }
}

output "kubeone_hosts" {
  description = "Control plane endpoints to SSH to"

  value = {
    control_plane = {
      cluster_name         = var.cluster_name
      cloud_provider       = "hetzner"
      private_address      = hcloud_server_network.control_plane.*.ip
      public_address       = hcloud_server.control_plane.*.ipv4_address
      network_id           = hcloud_network.net.id
      ssh_agent_socket     = var.ssh_agent_socket
      ssh_port             = var.ssh_port
      ssh_private_key_file = var.ssh_private_key_file
      ssh_user             = var.ssh_username
    }
  }
}

output "control_plane_info" {
  description = "Control plane informations"

  value = {
    image    = var.image
    location = var.datacenter
  }
}
