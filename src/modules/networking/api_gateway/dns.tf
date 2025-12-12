# resource "aws_api_gateway_domain_name" "api_gateway_domain" {
#   domain_name              = var.domain_name
#   regional_certificate_arn = var.certificate_arn
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }


# resource "aws_api_gateway_base_path_mapping" "api_gateway_mapping" {
#   domain_name = aws_api_gateway_domain_name.api_gateway_domain.domain_name
#   api_id      = aws_api_gateway_rest_api.api_gateway_rest.id
#   stage_name  = aws_api_gateway_stage.api_gateway_stage.stage_name
# }
