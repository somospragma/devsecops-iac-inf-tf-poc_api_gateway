variable "ecs_cluster_name" {
  description = "Nombre del ECS Cluster"
  type        = string
}

variable "settings" {
  description = "Configuraciones adicionales para el ECS Cluster"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "containerInsights"
      value = "enabled"
    }
  ]
}