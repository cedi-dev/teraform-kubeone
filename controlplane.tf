resource "hcloud_placement_group" "control_plane_placement" {
  name = "api placement"
  type = "spread"
  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }
}

resource "hcloud_server" "control_plane" {
  count              = var.control_plane_replicas
  name               = "api${count.index + 1}.${var.dns_domain}"
  server_type        = var.control_plane_type
  image              = var.image
  location           = var.datacenter
  placement_group_id = hcloud_placement_group.control_plane_placement.id

  ssh_keys = [
    hcloud_ssh_key.cedi_ivy.name,
    hcloud_ssh_key.cedi_liv.name,
    hcloud_ssh_key.cedi_mae.name,
    hcloud_ssh_key.ghaction.name
  ]

  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }
}
