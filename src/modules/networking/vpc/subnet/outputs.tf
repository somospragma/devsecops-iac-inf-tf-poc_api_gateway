output "subnet_id" {
  description = "The ID of the created subnet"
  value       = aws_subnet.subnet.id
}

output "cidr_block" {
  description = "cidr_block subnet"
  value = aws_subnet.subnet.cidr_block
}