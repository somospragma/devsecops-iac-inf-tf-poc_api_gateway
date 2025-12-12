variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

variable "routes" {
  description = "List of routes to be added to the route table"
  type = list(object({
    destination_cidr_block = string
    nat_gateway_id         = optional(string)
    transit_gateway_id     = optional(string)
    gateway_id             = optional(string)
    vpc_endpoint_id        = optional(string)
  }))
  default = []
}

variable "subnet_ids_and_gateways" {
  description = "Map of subnet_id and gateway_id"
  type = list(object({
    subnet_id  = optional(string)
    gateway_id = optional(string)
  }))
  default = []
}




