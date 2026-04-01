output "bastion_instance_id" {
  description = "EC2 instance ID of the bastion host"
  value       = aws_instance.bastionhost.id
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host — use this for SSH"
  value       = aws_instance.bastionhost.public_ip
}

output "bastion_private_ip" {
  description = "Private IP address of the bastion host"
  value       = aws_instance.bastionhost.private_ip
}
