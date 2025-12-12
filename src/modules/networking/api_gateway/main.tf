resource "aws_api_gateway_rest_api" "api_gateway_rest" {
  name        = var.api_gw_name
  description = var.description
  body        = var.file_swagger

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  tags = {
    Name = var.api_gw_name
  }
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway_rest.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  stage_name    = var.env
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest.id


  variables = {
    title     = aws_api_gateway_rest_api.api_gateway_rest.name
    vpcLinkId = var.vpclink_id
    nlb_dns   = var.nlb_dns_name
  }

  tags = {
    Name = var.api_gw_stage_name
  }
}
