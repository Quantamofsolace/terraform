output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_1_id" {
  description = "Subnet 1 ID"
  value       = aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  description = "Subnet 2 ID"
  value       = aws_subnet.subnet_2.id
}
