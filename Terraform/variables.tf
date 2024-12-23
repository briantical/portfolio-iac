variable "droplet" {
  type = object({
    region = string
    name   = string
    size   = string
  })
  default = {
    region = "fra1"
    name   = "portfolio"
    size   = "s-1vcpu-1gb"
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

variable "ssh_key_name" {
  type    = string
  default = "briantical"
}

variable "snapshot" {
  type = object({
    region     = string
    name_regex = string
  })
  default = {
    region     = "fra1"
    name_regex = "briantical-"
  }
}
