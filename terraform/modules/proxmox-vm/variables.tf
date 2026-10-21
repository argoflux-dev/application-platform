variable "name" {
  description = "Имя VM в Proxmox"
  type        = string
}

variable "vmid" {
  description = "VMID новой VM"
  type        = number
}

variable "target_node" {
  description = "Нода Proxmox"
  type        = string
}

variable "template_vmid" {
  description = "VMID шаблона для клонирования"
  type        = number
}

variable "storage" {
  description = "Storage для диска"
  type        = string
}

variable "network_bridge" {
  description = "Сетевой мост"
  type        = string
}

variable "cores" {
  description = "Количество vCPU"
  type        = number
}

variable "memory" {
  description = "Объём RAM, МБ"
  type        = number
}

variable "disk_size" {
  description = "Размер диска, ГБ"
  type        = number
}

variable "ip_address" {
  description = "Статический IPv4 без маски, например 192.168.150.131"
  type        = string
}

variable "ip_prefix" {
  description = "Длина префикса подсети"
  type        = number
  default     = 24
}

variable "gateway" {
  description = "Шлюз"
  type        = string
}

variable "dns_server" {
  description = "DNS-сервер"
  type        = string
}

variable "ci_username" {
  description = "Имя пользователя cloud-init"
  type        = string
}

variable "ssh_public_key" {
  description = "Содержимое публичного SSH-ключа"
  type        = string
}

variable "pool_id" {
  description = "Pool Proxmox, в который будет отнесена VM (для изоляции прав токена)"
  type        = string
}

variable "timeout_clone" {
  description = "Тайм-аут операции клонирования VM, секунды"
  type        = number
  default     = 600
}

variable "ansible_username" {
  description = "Имя служебного пользователя для Ansible, создаваемого через cloud-init"
  type        = string
}

variable "ansible_ssh_public_key" {
  description = "Содержимое публичного SSH-ключа пользователя ansible"
  type        = string
}

variable "snippet_datastore_id" {
  description = "Storage Proxmox с включённым типом контента Snippets"
  type        = string
  default     = "local"
}