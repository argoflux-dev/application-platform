resource "proxmox_virtual_environment_file" "cloud_init_user_data" {
  # ВАЖНО: этот ресурс использует ОТДЕЛЬНЫЙ provider-алиас (root@pam),
  # а не основной токен. Причина — Proxmox VE 9.x отклоняет чтение
  # полной конфигурации storage для API-токенов вне зависимости от прав.
  # Модуль должен получить этот alias через блок providers при вызове
  # (см. environments/k8s-lab/main.tf) и versions.tf модуля.
  provider = proxmox.root_session

  content_type = "snippets"
  datastore_id = var.snippet_datastore_id
  node_name    = var.target_node

  source_raw {
    file_name = "user-data-${var.name}.yaml"

    data = templatefile("${path.module}/templates/user-data.yaml.tftpl", {
      hostname        = var.name
      admin_user      = var.ci_username
      admin_ssh_key   = var.ssh_public_key
      ansible_user    = var.ansible_username
      ansible_ssh_key = var.ansible_ssh_public_key
    })
  }
}

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
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_user_data.id

    ip_config {
      ipv4 {
        address = "${var.ip_address}/${var.ip_prefix}"
        gateway = var.gateway
      }
    }

    dns {
      servers = [var.dns_server]
    }
  }

  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }
}