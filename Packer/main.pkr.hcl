# data "digitalocean-image" "example" {
#     name_regex = "golden-image-2022.*"
#     region     = "nyc3"
#     type       = "user"
#     latest     = true
# }

# locals {
#     image_id = data.digitalocean-image.example.image_id
# }

source "digitalocean" "source" {
  ipv6          = true
  monitoring    = true
  size          = var.source.size
  ssh_username  = var.ssh_username
  image         = var.source.image
  region        = var.source.region
  snapshot_name = "${var.source.snapshot_name}-{{timestamp}}"
}

build {
  hcp_packer_registry {
    bucket_labels = var.registry.labels
    bucket_name   = var.registry.bucket_name
    description   = var.registry.description

    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }

  sources = ["source.digitalocean.source"]

  provisioner "file" {
    sources      = ["files/certificate.pub", "files/portfolio-cert.pub"]
    destination = "/root/"
  }

  provisioner "shell" {
    script = "scripts/init.sh"
  }

  provisioner "shell" {
    script = "scripts/tailscale.sh"
  }

  provisioner "shell" {
    script = "scripts/cleanup.sh"
  }
}
