output "name" {
  value = proxmox_virtual_environment_vm.this.name
}

output "vmid" {
  value = proxmox_virtual_environment_vm.this.vm_id
}

output "ip_address" {
  value = var.ip_address
}
