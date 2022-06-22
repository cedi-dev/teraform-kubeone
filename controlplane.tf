resource "hcloud_placement_group" "control_plane_placement" {
  name = "api placement"
  type = "spread"
  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }
}

resource "hcloud_server" "control_plane1" {
  name               = "api1.${var.dns_domain}"
  server_type        = var.control_plane_type
  image              = var.image
  location           = var.datacenter
  placement_group_id = hcloud_placement_group.control_plane_placement.id

  ssh_keys = [
    hcloud_ssh_key.cedi_ivy.name,
    hcloud_ssh_key.cedi_mae.name,
    hcloud_ssh_key.ghaction.name
  ]

  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }
}

resource "cloudflare_record" "dns_v4_api1" {
  zone_id = var.cloudflare_zone_id
  name    = "api1"
  value   = hcloud_server.control_plane1.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "dns_v6_api1" {
  zone_id = var.cloudflare_zone_id
  name    = "api1"
  value   = hcloud_server.control_plane1.ipv6_address
  type    = "AAAA"
  ttl     = 1
  proxied = false
}

resource "hcloud_rdns" "rdns_api1" {
  server_id  = hcloud_server.control_plane1.id
  ip_address = hcloud_server.control_plane1.ipv4_address
  dns_ptr    = "api1.${var.dns_domain}"
}

resource "hcloud_server" "control_plane2" {
  name               = "api2.${var.dns_domain}"
  server_type        = var.control_plane_type
  image              = var.image
  location           = var.datacenter
  placement_group_id = hcloud_placement_group.control_plane_placement.id

  ssh_keys = [
    hcloud_ssh_key.cedi_ivy.name,
    hcloud_ssh_key.cedi_mae.name,
    hcloud_ssh_key.ghaction.name
  ]

  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }
}

resource "cloudflare_record" "dns_v4_api2" {
  zone_id = var.cloudflare_zone_id
  name    = "api2"
  value   = hcloud_server.control_plane2.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "dns_v6_api2" {
  zone_id = var.cloudflare_zone_id
  name    = "api2"
  value   = hcloud_server.control_plane2.ipv6_address
  type    = "AAAA"
  ttl     = 1
  proxied = false
}

resource "hcloud_rdns" "rdns_api2" {
  server_id  = hcloud_server.control_plane2.id
  ip_address = hcloud_server.control_plane2.ipv4_address
  dns_ptr    = "api2.${var.dns_domain}"
}

resource "hcloud_server" "control_plane3" {
  name               = "api3.${var.dns_domain}"
  server_type        = var.control_plane_type
  image              = var.image
  location           = var.datacenter
  placement_group_id = hcloud_placement_group.control_plane_placement.id

  ssh_keys = [
    hcloud_ssh_key.cedi_ivy.name,
    hcloud_ssh_key.cedi_mae.name,
    hcloud_ssh_key.ghaction.name
  ]

  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }
}

resource "cloudflare_record" "dns_v4_api3" {
  zone_id = var.cloudflare_zone_id
  name    = "api3"
  value   = hcloud_server.control_plane3.ipv4_address
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "dns_v6_api3" {
  zone_id = var.cloudflare_zone_id
  name    = "api3"
  value   = hcloud_server.control_plane3.ipv6_address
  type    = "AAAA"
  ttl     = 1
  proxied = false
}

resource "hcloud_rdns" "rdns_api3" {
  server_id  = hcloud_server.control_plane3.id
  ip_address = hcloud_server.control_plane3.ipv4_address
  dns_ptr    = "api3.${var.dns_domain}"
}