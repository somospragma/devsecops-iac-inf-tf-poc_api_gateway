variable "vpc_link_name" {
  description = "The name of the API Gateway VPC Link"
  type        = string
}

variable "description" {
  description = "A description for the API Gateway VPC Link"
  type        = string
  default     = "VPC Link for API Gateway to integrate with resources in a VPC"
}

variable "target_arn_list" {
  description = "A list of ARNs for the network load balancers (NLBs) to be associated with this VPC Link"
  type        = list(string)
}
