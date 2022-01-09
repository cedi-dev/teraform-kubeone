resource "hcloud_firewall" "api-fw" {
  name = "${var.cluster_name}-fw"

  labels = {
    "cluster" = var.cluster_name
    "role"    = "api"
  }

  apply_to {
    label_selector = "cluster=av0"
  }

  rule {
    description = "allow ICMP"
    direction   = "in"
    protocol    = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0",
    ]
  }

  rule {
    description = "allow all TCP inside cluster"
    direction   = "in"
    protocol    = "tcp"
    port        = "any"
    source_ips = [
      var.ip_range,
    ]
  }

  rule {
    description = "allow all UDP inside cluster"
    direction   = "in"
    protocol    = "udp"
    port        = "any"
    source_ips = [
      var.ip_range,
    ]
  }

  rule {
    description = "allow SSH from any"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0",
    ]
  }

  rule {
    description = "allow NodePorts from any"
    direction   = "in"
    protocol    = "tcp"
    port        = "30000-32767"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "allow kubectl from any"
    direction   = "in"
    protocol    = "tcp"
    port        = "6443"
    source_ips = [
      "0.0.0.0/0",
      "::/0",
    ]
  }

  rule {
    description = "allow hetzner api and metadata servers tcp"
    direction   = "in"
    protocol    = "tcp"
    port        = "any"
    source_ips = [
      "169.254.169.254/32",
      "213.239.246.1/32",
    ]
  }

  rule {
    description = "allow hetzner api and metadata servers udp"
    direction   = "in"
    protocol    = "udp"
    port        = "any"
    source_ips = [
      "169.254.169.254/32",
      "213.239.246.1/32",
    ]
  }
}
