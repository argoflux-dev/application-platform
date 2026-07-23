variable "proxmox_api_url" {
  type        = string
  description = "URL Proxmox API (например, https://192.168.150.200:8006/)"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "Полная строка токена Proxmox"
}

variable "target_node" {
  type    = string
  default = "pve"
}

variable "routeros_template_id" {
  type        = number
  description = "ID шаблона RouterOS"
}

variable "vm_count" {
  type    = number
  default = 3
}
