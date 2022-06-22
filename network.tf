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

resource "hcloud_server_network" "control_plane1" {
  server_id = hcloud_server.control_plane1.id
  subnet_id = hcloud_network_subnet.kubeone.id
}

resource "hcloud_server_network" "control_plane2" {
  server_id = hcloud_server.control_plane2.id
  subnet_id = hcloud_network_subnet.kubeone.id
}

resource "hcloud_server_network" "control_plane3" {
  server_id = hcloud_server.control_plane3.id
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

resource "hcloud_load_balancer_target" "lb_target_cp1" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  server_id        = hcloud_server.control_plane1.id
  use_private_ip   = true
  depends_on = [
    hcloud_server_network.control_plane1,
    hcloud_load_balancer_network.load_balancer
  ]
}

resource "hcloud_load_balancer_target" "lb_target_cp2" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  server_id        = hcloud_server.control_plane2.id
  use_private_ip   = true
  depends_on = [
    hcloud_server_network.control_plane2,
    hcloud_load_balancer_network.load_balancer
  ]
}

resource "hcloud_load_balancer_target" "lb_target_cp3" {
  type             = "server"
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  server_id        = hcloud_server.control_plane3.id
  use_private_ip   = true
  depends_on = [
    hcloud_server_network.control_plane3,
    hcloud_load_balancer_network.load_balancer
  ]
}

resource "hcloud_load_balancer_service" "api_service" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "tcp"
  listen_port      = 6443
  destination_port = 6443
}