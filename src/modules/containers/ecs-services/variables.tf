variable "env" {
  type        = string
  description = "Identificador para el entorno, ayuda a distinguir entre diferentes entornos de implementación como desarrollo, qa o producción"
}

variable "cluster_id" {
  type        = string
  description = "Nombre del clúster ECS (Elastic Container Service)."
}

variable "ecs_service_name" {
  type        = string
  description = "Nombre del servicio ECS (Elastic Container Service)"
}

variable "subnet_ecs" {
  description = "Subredes para el servicio ECS."
  type        = list(string)
}

variable "security_group" {
  description = "security group generico para todos los servicios desplegados en ECS"
  type = object({
    id = string
  })
}

variable "fargate_tg_arn" {
  description = "ARN para el grupo de destinos (target group)"
  type        = string
}

variable "container_resource" {
  description = "Nombre del contenedor y el puerto por el cual queda ala escucha"
  type = object({
    name = string
    port = number
  })
}

variable "logs_group_name_service" {
  description = "Nombre del grupo de logs en CloudWatch para el servicio."
  type        = string
}

variable "policy_role" {
  description = "Nombre de la política en Secrets Manager."
  type        = string
}



variable "effect_policy" {
  description = "efecto de la politica allow o deny"
  type        = string
}


variable "ecs_execution_role" {
  description = "Rol de ejecución ECS para el servicio."
  type        = string
}


variable "task_name" {
  type        = string
  description = "nombre de la task definition"
}

