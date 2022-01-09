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

resource "hcloud_server_network" "control_plane" {
  count     = var.control_plane_replicas
  server_id = element(hcloud_server.control_plane.*.id, count.index)
  subnet_id = hcloud_network_subnet.kubeone.id
}

resource "hcloud_load_balancer_network" "load_balancer" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  subnet_id        = hcloud_network_subnet.kubeone.id
}

resource "hcloud_load_balancer" "load_balancer" {
  name               = "${var.cluster_name}-api-lb"
  load_balancer_type = var.lb_type
  location           = var.datacenter

  labels = {
    "cluster" = var.cluster_name
    "role"    = "lb"
  }
}

resource "hcloud_load_balancer_target" "load_balancer_target" {
  count            = var.control_plane_replicas
  type             = "server"
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  server_id        = element(hcloud_server.control_plane.*.id, count.index)
  use_private_ip   = true
  depends_on = [
    hcloud_server_network.control_plane,
    hcloud_load_balancer_network.load_balancer
  ]
}

resource "hcloud_load_balancer_service" "api_service" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "tcp"
  listen_port      = 6443
  destination_port = 6443
}