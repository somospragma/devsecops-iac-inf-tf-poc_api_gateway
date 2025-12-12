#################################################################################
# security group
#################################################################################
module "sg_poc" {
  source      = "../modules/security/security_group"
  sg_name     = "${var.env}-sg-frontend"
  description = "Grupo de seguridad poc"
  vpc_id      = module.vpc_poc.vpc_id
  ingress_ports_list = [
    {
      protocol    = "tcp"
      from_port   = 80
      port        = 80,
      name        = "Frontend HTTP",
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      protocol    = "tcp"
      from_port   = 5000
      port        = 5000,
      name        = "tcp-poc",
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  depends_on = [
    module.vpc_poc
  ]
}
