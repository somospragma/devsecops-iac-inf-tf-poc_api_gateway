variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "ingress_ports_list" {
  description = "List of objects with ports and optional names for ingress rules"
  type = list(object({
    from_port   = number
    port        = number
    name        = string
    cidr_blocks = list(string)
    protocol    = string
  }))
  default = []
}

variable "port_ranges" {
  description = "List of objects with port ranges for ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    name        = optional(string)
    cidr_blocks = list(string)
    protocol    = string
  }))
  default = []
}

variable "vpc_id" {
  description = "ID of the Virtual Private Cloud (VPC)"
  type        = string
}
