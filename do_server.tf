terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "laptop" {
  name = "laptop"
}

resource "digitalocean_droplet" "devza" {
  image  = "ubuntu-18-04-x64"
  name   = "devza"
  region = "lon1"
  size   = "s-2vcpu-4gb"
  ssh_keys = [
      data.digitalocean_ssh_key.laptop.id
  ]
}

output "droplet_ip_addresses" {
  value = digitalocean_droplet.devza.ipv4_address
}