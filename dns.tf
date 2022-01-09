resource "hetznerdns_zone" "dns" {
  name = var.dns_domain
  ttl  = 60
}

resource "hetznerdns_record" "dns_api_v4" {
  zone_id = hetznerdns_zone.dns.id
  name    = "api"
  value   = hcloud_load_balancer.load_balancer.ipv4
  type    = "A"
  ttl     = 600
}

resource "hetznerdns_record" "dns_api_v6" {
  zone_id = hetznerdns_zone.dns.id
  name    = "api"
  value   = hcloud_load_balancer.load_balancer.ipv6
  type    = "AAAA"
  ttl     = 600
}

resource "hetznerdns_record" "dns_api_host_v4" {
  zone_id = hetznerdns_zone.dns.id
  name    = "api${count.index + 1}"
  count   = var.control_plane_replicas
  value   = element(hcloud_server.control_plane.*.ipv4_address, count.index)
  type    = "A"
  ttl     = 600
}

resource "hetznerdns_record" "dns_api_host_v6" {
  zone_id = hetznerdns_zone.dns.id
  name    = "api${count.index + 1}"
  count   = var.control_plane_replicas
  value   = element(hcloud_server.control_plane.*.ipv6_address, count.index)
  type    = "AAAA"
  ttl     = 600
}

resource "hcloud_rdns" "master" {
  count      = var.control_plane_replicas
  server_id  = element(hcloud_server.control_plane.*.id, count.index)
  ip_address = element(hcloud_server.control_plane.*.ipv4_address, count.index)
  dns_ptr    = "api${count.index + 1}.${hetznerdns_zone.dns.name}"
}