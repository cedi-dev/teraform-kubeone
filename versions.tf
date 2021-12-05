terraform {
  required_version = ">= 1.0.9"
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    hetznerdns = {
      source  = "timohirt/hetznerdns"
      version = "1.2.0"
    }
  }

  backend "remote" {
    organization = "cedi"

    workspaces {
      name = "k8s-av0-de"
    }
  }
}
