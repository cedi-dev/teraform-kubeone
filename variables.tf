variable "cluster_name" {
  description = "prefix for cloud resources"
}

variable "worker_os" {
  description = "OS to run on worker machines"

  # valid choices are:
  # * ubuntu
  # * centos
  default = "ubuntu"
}

variable "ssh_port" {
  description = "SSH port to be used to provision instances"
  default     = 22
}

variable "ssh_username" {
  description = "SSH user, used only in output"
  default     = "root"
}

variable "ssh_private_key_file" {
  description = "SSH private key file used to access instances"
  default     = ""
}

variable "ssh_agent_socket" {
  description = "SSH Agent socket, default to grab from $SSH_AUTH_SOCK"
  default     = "env:SSH_AUTH_SOCK"
}

# Provider specific settings

variable "control_plane_replicas" {
  default = 3
}

variable "control_plane_type" {
  default = "cx21"
}

variable "worker_type" {
  default = "cx21"
}

variable "dist_upgrade_on_boot" {
  default = false
}

variable "lb_type" {
  default = "lb11"
}

variable "datacenter" {
  default = "nbg1"
}

variable "image" {
  default = "ubuntu-20.04"
}

variable "ip_range" {
  default     = "192.168.0.0/16"
  description = "ip range to use for private network"
}

variable "network_zone" {
  default     = "eu-central"
  description = "network zone to use for private network"
}
