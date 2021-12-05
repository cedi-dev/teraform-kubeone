
resource "hcloud_server_network" "control_plane" {
  count     = var.control_plane_replicas
  server_id = element(hcloud_server.control_plane.*.id, count.index)
  subnet_id = hcloud_network_subnet.kubeone.id
}

resource "hcloud_server" "control_plane" {
  count       = var.control_plane_replicas
  name        = "${var.cluster_name}-control-plane-${count.index + 1}"
  server_type = var.control_plane_type
  image       = var.image
  location    = var.datacenter

  ssh_keys = [
    hcloud_ssh_key.cedi_ivy.name,
    hcloud_ssh_key.cedi_ava.name,
    hcloud_ssh_key.cedi_liv.name,
    hcloud_ssh_key.ghaction.name
  ]

  labels = {
    "kubeone_cluster_name" = var.cluster_name
    "role"                 = "api"
  }
}
