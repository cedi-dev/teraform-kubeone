resource "cloudflare_record" "dns_api_v4" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value   = hcloud_load_balancer.load_balancer.ipv4
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "dns_api_v6" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value   = hcloud_load_balancer.load_balancer.ipv6
  type    = "AAAA"
  ttl     = 1
  proxied = false
}
