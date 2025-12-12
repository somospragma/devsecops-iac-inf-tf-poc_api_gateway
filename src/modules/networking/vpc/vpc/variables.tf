variable "vpc_cidr_block" {
  description = "The CIDR block to associate with the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name to assign to the VPC tag"
  type        = string
}

variable "igw_name" {
  description = "The name to assign to the Internet Gateway tag"
  type        = string
}
