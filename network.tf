resource "hcloud_network" "net" {
  name     = var.cluster_name
  ip_range = var.ip_range
}

resource "hcloud_network_subnet" "kubeone" {
  network_id   = hcloud_network.net.id
  type         = "server"
  network_zone = var.network_zone
  ip_range     = var.ip_range
}

resource "hcloud_load_balancer_network" "load_balancer" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  subnet_id        = hcloud_network_subnet.kubeone.id
}

resource "hcloud_load_balancer" "load_balancer" {
  name               = "${var.cluster_name}-lb"
  load_balancer_type = var.lb_type
  location           = var.datacenter

  labels = {
    "kubeone_cluster_name" = var.cluster_name
    "role"                 = "lb"
  }
}

resource "hcloud_load_balancer" "dns_lb" {
  name               = "${var.cluster_name}-dns-lb"
  load_balancer_type = var.lb_type
  location           = var.datacenter

  labels = {
    "kubeone_cluster_name" = var.cluster_name
    "role"                 = "lb"
  }
}
