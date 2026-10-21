# --- Подключение к Proxmox ---

variable "proxmox_endpoint" {
  description = "URL Proxmox API, например https://192.168.150.200:8006/api2/json"
  type        = string
}

variable "proxmox_api_token" {
  description = "API-токен в формате user@realm!token-id=secret"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Пропускать проверку TLS-сертификата (true для самоподписанного сертификата лабы)"
  type        = bool
  default     = true
}

# --- Общие параметры кластера ---

variable "target_node" {
  description = "Имя ноды Proxmox, на которой разворачиваются VM"
  type        = string
  default     = "pveoap"
}

variable "template_vmid" {
  description = "VMID шаблона cloud-init Ubuntu, созданного на шаге 1"
  type        = number
  default     = 9001
}

variable "storage" {
  description = "Имя storage для дисков VM"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Сетевой мост Proxmox"
  type        = string
  default     = "vmbr0"
}

variable "gateway" {
  description = "Шлюз сети"
  type        = string
  default     = "192.168.150.1"
}

variable "dns_server" {
  description = "DNS-сервер для узлов"
  type        = string
  default     = "8.8.8.8"
}

variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу, который будет добавлен в cloud-init"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ci_username" {
  description = "Имя пользователя, создаваемого cloud-init на каждой VM"
  type        = string
  default     = "websanta"
}

variable "pool_id" {
  description = "Pool Proxmox для изоляции VM этого стенда (должен быть создан заранее вручную)"
  type        = string
  default     = "k8s-lab"
}

# --- Описание узлов кластера ---

variable "nodes" {
  description = "Карта узлов кластера: имя => параметры"
  type = map(object({
    vmid   = number
    role   = string # control-plane | worker
    cores  = number
    memory = number
    disk   = number
    ip     = string
  }))
}

variable "ansible_username" {
  description = "Имя служебного пользователя для автоматизации Ansible (отдельный от административного пользователя-человека)"
  type        = string
  default     = "ansible"
}

variable "ansible_ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу пользователя ansible. Ключ генерируется один раз вручную командой: ssh-keygen -t ed25519 -f ~/.ssh/ansible_k8s_lab -C \"ansible-automation\" -N \"\" — и переиспользуется для всех ВМ кластера"
  type        = string
  default     = "~/.ssh/ansible_k8s_lab.pub"
}

# --- аутентификация root@pam для загрузки cloud-init snippets ---

variable "proxmox_root_password" {
  description = "Пароль пользователя root@pam. Используется ИСКЛЮЧИТЕЛЬНО для второго provider-алиаса (proxmox.root_session, см. providers.tf), который загружает cloud-init snippets. Причина: Proxmox VE 9.x отклоняет чтение полной конфигурации storage (GET /storage/{storage}) для любых API-токенов вне зависимости от прав — подтверждено экспериментально curl-запросом. Для операций с ВМ (создание, диски) этот пароль не используется, там применяется ограниченный по правам API-токен."
  type        = string
  sensitive   = true
}