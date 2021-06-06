cluster_name = "k8s.cedi.dev"
worker_os = "ubuntu"
ssh_public_key_file = "~/.ssh/id_ed25519.pub"
ssh_port = 22
ssh_username = "root"
control_plane_type = "cx21"
worker_type = "cx21"
workers_replicas = 1
lb_type = "lb11"
datacenter = "nbg1"
image = "ubuntu-20.04"
ip_range = "192.168.0.0/16"
network_zone = "eu-central"
