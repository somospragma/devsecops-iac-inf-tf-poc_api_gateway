output "lb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.lb.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.lb.dns_name
}
