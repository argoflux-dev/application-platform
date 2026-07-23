terraform {
  required_version = ">= 1.15.8"
}

# МИКРОТИК 1
resource "null_resource" "mikrotik_1" {
  provisioner "local-exec" {
    command = "curl -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_token}' ${var.proxmox_api_url}api2/json/nodes/${var.target_node}/qemu/${var.routeros_template_id}/clone?newid=111&full=1&name=mikrotik-lab-1&storage=local-lvm && sleep 3 && curl -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_token}' ${var.proxmox_api_url}api2/json/nodes/${var.target_node}/qemu/111/status/start"
  }
}

# МИКРОТИК 2
resource "null_resource" "mikrotik_2" {
  provisioner "local-exec" {
    command = "curl -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_token}' ${var.proxmox_api_url}api2/json/nodes/${var.target_node}/qemu/${var.routeros_template_id}/clone?newid=112&full=1&name=mikrotik-lab-2&storage=local-lvm && sleep 3 && curl -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_token}' ${var.proxmox_api_url}api2/json/nodes/${var.target_node}/qemu/112/status/start"
  }
}

# МИКРОТИК 3
resource "null_resource" "mikrotik_3" {
  provisioner "local-exec" {
    command = "curl -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_token}' ${var.proxmox_api_url}api2/json/nodes/${var.target_node}/qemu/${var.routeros_template_id}/clone?newid=113&full=1&name=mikrotik-lab-3&storage=local-lvm && sleep 3 && curl -k -X POST -H 'Authorization: PVEAPIToken=${var.proxmox_api_token}' ${var.proxmox_api_url}api2/json/nodes/${var.target_node}/qemu/113/status/start"
  }
}
