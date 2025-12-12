variable "lb_name" {
  description = "The name of the load balancer. It must be unique within your AWS account"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or internet-facing. Set to true for internal, false for internet-facing"
  type        = bool
}

variable "lb_type" {
  description = "The type of the load balancer. Valid values are 'application' or 'network'"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the load balancer."
  type        = list(string)
}

variable "sg_ids" {
  description = "A list of security group IDs to associate with the load balancer."
  type        = list(string)
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection on the load balancer. Set to true to prevent accidental deletions"
  type        = bool
}

variable "cross_zone_load_balancing" {
  description = "Whether to enable cross-zone load balancing on the load balancer. This improves traffic distribution across multiple zones"
  type        = bool
}
