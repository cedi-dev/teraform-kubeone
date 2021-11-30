resource "hetznerdns_zone" "av0_de" {
  name = "av0.de"
  ttl  = 60
}

resource "hetznerdns_record" "av0_de_test" {
  zone_id = hetznerdns_zone.av0_de.id
  name    = "@"
  value   = "test"
  type    = "TXT"
  ttl     = 5
}
