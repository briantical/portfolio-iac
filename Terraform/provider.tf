terraform {
  backend "remote" {
    organization = "briantical"
    workspaces {
      name = "Development"
    }

  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}
