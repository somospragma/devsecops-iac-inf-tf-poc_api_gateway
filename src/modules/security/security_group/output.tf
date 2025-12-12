output "sg_id" {
  description = "The security group ID to be used in other resources"
  value       = aws_security_group.sg.id
}
