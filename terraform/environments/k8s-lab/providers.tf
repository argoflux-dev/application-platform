terraform {
  required_version = ">= 1.15"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.87"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure

  ssh {
    agent = true
  }
}
