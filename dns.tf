resource "hetznerdns_zone" "dns" {
  name = var.dns_domain
  ttl  = 60
}

resource "hetznerdns_record" "dns_api" {
  zone_id = hetznerdns_zone.dns.id
  name    = "api"
  count   = var.control_plane_replicas
  value   = element(hcloud_server.control_plane.*.ipv4_address, count.index)
  type    = "A"
  ttl     = 600
}
