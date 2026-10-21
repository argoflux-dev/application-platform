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

# Второй экземпляр того же провайдера, с алиасом "root_session".
# Используется ТОЧЕЧНО, только там, где явно указано
# provider = proxmox.root_session (сейчас — только в
# modules/proxmox-vm/main.tf, ресурс proxmox_virtual_environment_file).

provider "proxmox" {
  alias    = "root_session"
  endpoint = var.proxmox_endpoint
  username = "root@pam"
  password = var.proxmox_root_password
  insecure = var.proxmox_insecure

  ssh {
    agent = true
  }
}