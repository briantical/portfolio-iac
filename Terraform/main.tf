data "digitalocean_droplet_snapshot" "snapshot" {
  most_recent = true
  region      = var.snapshot.region
  name_regex  = var.snapshot.name_regex
}

resource "digitalocean_droplet" "droplet" {
  monitoring = true
  ipv6       = true
  # ssh_keys   = var.ssh_key_list
  name   = var.droplet.name
  size   = var.droplet.size
  region = var.droplet.region
  image  = data.digitalocean_droplet_snapshot.snapshot.id

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
