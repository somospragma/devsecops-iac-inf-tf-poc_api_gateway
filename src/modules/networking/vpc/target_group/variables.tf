variable "tg_name" {
  description = "Name of the Target Group"
  type        = string
}

variable "tg_port" {
  description = "Port of the Target Group"
  type        = number
  default     = 80
}

variable "tg_protocol" {
  description = "Protocol for the Target Group (HTTP, HTTPS, or TCP)"
  type        = string
  default     = "TCP"
}

variable "vpc_id" {
  description = "ID of the VPC where the Target Group is located"
  type        = string
}

variable "target_type" {
  description = "Type of target (instance, ip, or lambda)"
  type        = string
  default     = "ip"
}

variable "health_check_config" {
  description = "Health check configuration for the Target Group. Provide only the fields you want to override."
  type = object({
    path                = optional(string)
    interval            = optional(number)
    protocol            = optional(string)
    healthy_threshold   = optional(number)
    unhealthy_threshold = optional(number)
    timeout             = optional(number)
  })
  default = {}
}

variable "listener_config" {
  description = "Configuration for the NLB listener, including ARN, protocol, port, and listener name."
  type = object({
    lb_arn           = string
    listener_protocol = string
    listener_port     = number
    listener_name     = string
  })
}
