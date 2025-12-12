##################################################################################
# VpcLink
##################################################################################
module "vpc_link_nlb_poc" {
  source        = "../modules/networking/vpc_link"
  vpc_link_name = "${var.env}-vpc-link-nlb-poc"
  description   = "VPC Link para API Gateway para conectarse a NLBs"
  target_arn_list = [
    module.network_load_balancer_poc.lb_arn
  ]

  depends_on = [
    module.network_load_balancer_poc
  ]
}


###################################################################################
# Rest Api Public 
###################################################################################
module "api_gateway_poc_public" {
  source            = "../modules/networking/api_gateway"
  api_gw_name       = "${var.env}-api-gtw-rest-${var.project_name}-public"
  description       = "Portal Autogestión"
  file_swagger      = local.swagger_api_public
  endpoint_type     = "REGIONAL"
  env               = var.env
  vpclink_id        = module.vpc_link_nlb_poc.vpc_link_id
  nlb_dns_name      = module.network_load_balancer_poc.lb_dns_name
  api_gw_stage_name = "${var.env}-api-gtw-stage-poc-public"


  depends_on = [
    module.vpc_link_nlb_poc,
    module.network_load_balancer_poc
  ]
}
