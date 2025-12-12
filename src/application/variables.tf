variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "subnet_public_az_a_cidr_blocks" {
  description = "CIDR subnet"
  type        = string
}


variable "subnet_public_az_b_cidr_blocks" {
  description = "CIDR subnet"
  type        = string
}
