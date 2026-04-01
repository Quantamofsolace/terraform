output "frontend_instance_id" {
  description = "EC2 instance ID of the frontend golden instance"
  value       = aws_instance.frontend.id
}

output "frontend_public_ip" {
  description = "Public IP of the frontend instance — use for initial SSH verification"
  value       = aws_instance.frontend.public_ip
}

output "frontend_private_ip" {
  description = "Private IP of the frontend instance"
  value       = aws_instance.frontend.private_ip
}

output "frontend_instanceid" {
  description = "Alias of frontend_instance_id — passed to launch-template module as source for AMI baking"
  value       = aws_instance.frontend.id
}
