resource "aws_lb" "lb" {
  name                             = var.lb_name
  internal                         = var.internal
  load_balancer_type               = var.lb_type
  subnets                          = var.subnets
  security_groups                  = var.sg_ids
  enable_deletion_protection       = var.deletion_protection
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing

  tags = {
    Name = var.lb_name
  }
}
