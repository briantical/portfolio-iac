variable "image" {
  type = object({
    name   = string
    type   = string
    region = string
  })
  default = {
    name   = "ubuntu-20-04-x64"
    type   = "user"
    region = "fra1"
  }
}

variable "source" {
  type = object({
    size          = string
    region        = string
    image         = string
    snapshot_name = string
  })
  default = {
    snapshot_name = "briantical"
    image         = "ubuntu-22-04-x64"
    size          = "s-1vcpu-1gb"
    region        = "fra1"
  }
}

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
}

variable "ssh_username" {
  type      = string
  default   = "root"
  sensitive = true
}

variable "registry" {
  type = object({
    bucket_name = string
    description = string
    labels      = map(string)
  })
  default = {
    bucket_name = "briantical-portfolio-images"
    description = "Droplet images for the portfolio site"
    labels = {
      "owner"          = "briantical"
      "os"             = "Ubuntu"
      "ubuntu-version" = "22.04"
    }
  }
}