resource "proxmox_virtual_environment_vm" "this" {
  name      = var.name
  node_name = var.target_node
  vm_id     = var.vmid
  pool_id   = var.pool_id

  clone {
    vm_id   = var.template_vmid
    full    = true
    retries = 3
  }

  timeout_clone = var.timeout_clone

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
    type  = "host"
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    size         = var.disk_size
  }

  network_device {
    bridge = var.network_bridge
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${var.ip_address}/${var.ip_prefix}"
        gateway = var.gateway
      }
    }

    dns {
      servers = [var.dns_server]
    }

    user_account {
      username = var.ci_username
      keys     = [var.ssh_public_key]
    }
  }

  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }
}
