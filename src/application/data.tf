#Current account number
data "aws_caller_identity" "current" {}
#Current AWS Region
data "aws_region" "current" {}

######################################################################################
#Data Yaml Api Rest Public
######################################################################################
data "template_file" "template_file_api_swagger_public" {
  template = file("files/api_gateway/api-poc-manual-poc-swagger-apigateway.yaml")

  vars = {
    env = "${var.env}"
  }
}




