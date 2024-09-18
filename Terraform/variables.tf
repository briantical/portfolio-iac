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
    image  = "ubuntu-20-04-x64"
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

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
}

variable "ssh_key_list" {
  type      = list(string)
  sensitive = true
  default   = []
}
