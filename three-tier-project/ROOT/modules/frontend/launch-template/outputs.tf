output "frontend_launch_template_id" {
  description = "ID of the frontend launch template — referenced by the frontend ASG module"
  value       = aws_launch_template.frontend.id
}

output "frontend_launch_template_name" {
  description = "Name of the frontend launch template"
  value       = aws_launch_template.frontend.name
}

output "frontend_launch_template_arn" {
  description = "ARN of the frontend launch template"
  value       = aws_launch_template.frontend.arn
}

output "frontend_ami_id" {
  description = "ID of the AMI baked from the frontend golden instance"
  value       = aws_ami_from_instance.ami_frontend.id
}
