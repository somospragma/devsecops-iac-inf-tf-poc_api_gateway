
module "network_load_balancer_poc" {
  source   = "../modules/networking/vpc/load-balancer"
  lb_name  = "${var.env}-nlb-poc"
  internal = true
  lb_type  = "network"
  subnets = [
    module.subnet_public_az_a.subnet_id,
    module.subnet_public_az_b.subnet_id,
  ]
  sg_ids = [
    module.sg_poc.sg_id
  ]
  deletion_protection       = false
  cross_zone_load_balancing = true

  depends_on = [
    module.subnet_public_az_a,
    module.subnet_public_az_b,
    module.sg_poc
  ]
}



module "lb_target_group_poc" {
  source  = "../modules/networking/vpc/target_group"
  tg_name = "${var.env}-tg-ms-poc"
  vpc_id  = module.vpc_poc.vpc_id


  listener_config = {
    lb_arn            = module.network_load_balancer_poc.lb_arn
    listener_protocol = "TCP"
    listener_port     = 5000
    listener_name     = "${var.env}-listener-nlb-poc"
  }
}