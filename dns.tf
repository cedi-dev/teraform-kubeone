resource "cloudflare_record" "dns_api_v4" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value   = hcloud_load_balancer.load_balancer.ipv4
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "dns_api_v6" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value   = hcloud_load_balancer.load_balancer.ipv6
  type    = "AAAA"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "dns_api_host_v4" {
  zone_id = var.cloudflare_zone_id
  name    = "api${count.index + 1}"
  count   = var.control_plane_replicas
  value   = element(hcloud_server.control_plane.*.ipv4_address, count.index)
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "dns_api_host_v6" {
  zone_id = var.cloudflare_zone_id
  name    = "api${count.index + 1}"
  count   = var.control_plane_replicas
  value   = element(hcloud_server.control_plane.*.ipv6_address, count.index)
  type    = "AAAA"
  ttl     = 1
  proxied = false
}

resource "hcloud_rdns" "master" {
  count      = var.control_plane_replicas
  server_id  = element(hcloud_server.control_plane.*.id, count.index)
  ip_address = element(hcloud_server.control_plane.*.ipv4_address, count.index)
  dns_ptr    = "api${count.index + 1}.${var.dns_domain}"
}