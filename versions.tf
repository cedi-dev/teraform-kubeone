terraform {
  required_version = ">= 0.12"
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }

  backend "remote" {
    organization = "cedi"

    workspaces {
      name = "k8s-cedi-dev"
    }
  }
}
