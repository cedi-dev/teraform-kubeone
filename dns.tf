resource "hetznerdns_zone" "av0_de" {
  name = "av0.de"
  ttl  = 60
}

resource "hetznerdns_record" "av0_de_api" {
  zone_id = hetznerdns_zone.av0_de.id
  name    = "api"
  count   = var.control_plane_replicas
  value   = element(hcloud_server.control_plane.*.ipv4_address, count.index)
  type    = "A"
  ttl     = 5
}
