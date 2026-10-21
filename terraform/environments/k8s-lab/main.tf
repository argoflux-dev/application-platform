module "node" {
  source = "../../modules/proxmox-vm"

  providers = {
    proxmox               = proxmox
    proxmox.root_session  = proxmox.root_session
  }

  for_each = var.nodes

  name           = each.key
  vmid           = each.value.vmid
  target_node    = var.target_node
  template_vmid  = var.template_vmid
  storage        = var.storage
  network_bridge = var.network_bridge

  cores     = each.value.cores
  memory    = each.value.memory
  disk_size = each.value.disk

  ip_address = each.value.ip
  gateway    = var.gateway
  dns_server = var.dns_server

  ci_username    = var.ci_username
  ssh_public_key = trimspace(file(pathexpand(var.ssh_public_key_path)))
  pool_id        = var.pool_id

  ansible_username       = var.ansible_username
  ansible_ssh_public_key = trimspace(file(pathexpand(var.ansible_ssh_public_key_path)))
}
