output "backend_instance_id" {
  description = "EC2 instance ID of the backend golden instance"
  value       = aws_instance.backend.id
}

output "backend_public_ip" {
  description = "Public IP of the backend instance (only available if launched in public subnet)"
  value       = aws_instance.backend.public_ip
}

output "backend_private_ip" {
  description = "Private IP of the backend instance — used for internal communication"
  value       = aws_instance.backend.private_ip
}

output "backend_instanceid" {
  description = "Alias of backend_instance_id — passed to launch-template module as source for AMI baking"
  value       = aws_instance.backend.id
}
