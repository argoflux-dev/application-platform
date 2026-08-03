output "nodes" {
  description = "Итоговая карта узлов: имя => {ip, role}"
  value = {
    for name, node in var.nodes :
    name => {
      ip   = node.ip
      role = node.role
    }
  }
}
