variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "subnet_availability_zone" {
  description = "The Availability Zone in which the subnet will be created"
  type        = string
}

variable "subnet_name" {
  description = "The name tag for the subnet"
  type        = string
}
