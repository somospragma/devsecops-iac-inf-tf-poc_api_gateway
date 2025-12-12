resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = var.vpc_link_name
  description = var.description
  target_arns = var.target_arn_list

  tags = {
    Name = var.vpc_link_name
  }
}
