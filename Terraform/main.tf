

resource "digitalocean_droplet" "droplet" {
  monitoring = true
  ipv6       = true
  name       = var.droplet.name
  size       = var.droplet.size
  image      = var.droplet.image
  region     = var.droplet.region

  tags = ["Terraform", "Portfolio"]
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
