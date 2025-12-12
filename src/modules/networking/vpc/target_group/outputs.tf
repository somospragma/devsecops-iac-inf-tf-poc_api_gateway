output "tg_arn" {
  description = "arn target group"
  value       = aws_lb_target_group.tg.arn
}