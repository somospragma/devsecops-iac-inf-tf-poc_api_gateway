resource "aws_lb_target_group" "tg" {
  name        = var.tg_name
  port        = var.tg_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_config.path
    interval            = var.health_check_config.interval
    protocol            = var.health_check_config.protocol
    healthy_threshold   = var.health_check_config.healthy_threshold
    unhealthy_threshold = var.health_check_config.unhealthy_threshold
    timeout             = var.health_check_config.timeout
  }

  tags = {
    Name = var.tg_name
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = var.listener_config.lb_arn
  protocol          = var.listener_config.listener_protocol
  port              = var.listener_config.listener_port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  tags = {
    Name = var.listener_config.listener_name
  }
}
