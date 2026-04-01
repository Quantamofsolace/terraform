output "backend_launch_template_id" {
  description = "ID of the backend launch template — referenced by the backend ASG module"
  value       = aws_launch_template.backend.id
}

output "backend_launch_template_name" {
  description = "Name of the backend launch template"
  value       = aws_launch_template.backend.name
}

output "backend_launch_template_arn" {
  description = "ARN of the backend launch template"
  value       = aws_launch_template.backend.arn
}

output "backend_ami_id" {
  description = "ID of the AMI baked from the backend golden instance"
  value       = aws_ami_from_instance.ami_backend.id
}
