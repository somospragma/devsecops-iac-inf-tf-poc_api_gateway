output "vpc_link_id" {
  description = "The ID of the API Gateway VPC Link"
  value       = aws_api_gateway_vpc_link.vpc_link.id
}

output "vpc_link_arn" {
  description = "The ARN of the API Gateway VPC Link"
  value       = aws_api_gateway_vpc_link.vpc_link.arn
}
