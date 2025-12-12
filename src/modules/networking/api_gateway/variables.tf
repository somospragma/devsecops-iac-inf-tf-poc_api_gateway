variable "api_gw_name" {
  description = "The name of the API Gateway REST API"
  type        = string
}

variable "description" {
  description = "A brief description of the API Gateway REST API"
  type        = string
  default     = "API Gateway created using Terraform"
}

variable "file_swagger" {
  description = "The Swagger/OpenAPI specification file that defines the API. Use `file()` to load the file"
  type        = string
}

variable "endpoint_type" {
  description = "The endpoint type of the API Gateway REST API. Possible values: EDGE, REGIONAL, or PRIVATE"
  type        = string
  default     = "REGIONAL"
}

variable "env" {
  description = "The environment identifier to distinguish between different deployment environments like development, QA, or production"
  type        = string
}

variable "vpclink_id" {
  description = "The ID of the VPC Link to be used by the API Gateway stage."
  type        = string
}

variable "nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer (NLB) that the API Gateway stage should connect to"
  type        = string
}

variable "api_gw_stage_name" {
  description = "The name of the API Gateway stage (e.g., 'dev', 'prod')"
  type        = string
}

# variable "domain_name" {
#   description = "The domain name to be used for the API in API Gateway. It should be a valid domain in Amazon Route 53 or a custom domain."
#   type        = string
# }

# variable "certificate_arn" {
#   description = "The ARN of the SSL certificate to be used for securing HTTPS communication on the API Gateway domain. This certificate should be stored in AWS Certificate Manager (ACM)."
#   type        = string
# }
