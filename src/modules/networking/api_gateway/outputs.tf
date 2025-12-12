output "api_gtw_id" {
  description = "The ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.api_gateway_rest.id
}

output "api_gtw_execution_arn" {
  description = "The execution ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.api_gateway_rest.execution_arn
}

# output "regional_domain_name" {
#   description = "The regional domain name of the custom API Gateway domain"
#   value       = aws_api_gateway_domain_name.api_gateway_domain.regional_domain_name
# }

# output "regional_zone_id" {
#   description = "The Route 53 hosted zone ID for the custom API Gateway domain"
#   value       = aws_api_gateway_domain_name.api_gateway_domain.regional_zone_id
# }



