variable "droplet" {
  type = object({
    region = string
    name   = string
    size   = string
    image  = string
  })
  default = {
    region = "fra1"
    name   = "portfolio"
    size   = "s-1vcpu-1gb"
    image  = "118857366"
  }
}

variable "project" {
  type = object({
    name        = string
    description = string
    purpose     = string
    environment = string
  })
  default = {
    name        = "Portfolio"
    environment = "Development"
    purpose     = "Service or API"
    description = "Personal portfolio project"
  }
}

variable "domain" {
  type = object({
    name = string
  })
  default = {
    name = "briantical.dev"
  }
}

variable "tailscale" {
  type = object({
    auth_key = string
  })
  sensitive = true
}

