resource "digitalocean_droplet" "droplet" {
  monitoring = true
  ipv6       = true
  ssh_keys   = var.ssh_key_list
  name       = var.droplet.name
  size       = var.droplet.size
  image      = var.droplet.image
  region     = var.droplet.region

  user_data = templatefile("${path.module}/templates/cloud-init.tftpl", {
    tailscale_auth_key = var.tailscale_auth_key
  })

  tags = ["terraform", "portfolio"]
}

resource "digitalocean_domain" "domain" {
  name = var.domain.name
}

resource "digitalocean_project" "project" {
  name        = var.project.name
  description = var.project.description
  purpose     = var.project.purpose
  environment = var.project.environment

}

resource "digitalocean_project_resources" "project_resources" {
  project   = digitalocean_project.project.id
  resources = [digitalocean_droplet.droplet.urn, digitalocean_domain.domain.urn]
}
