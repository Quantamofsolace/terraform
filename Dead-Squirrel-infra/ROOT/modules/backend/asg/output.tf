output "backend_asg_name" {
  description = "Name of the backend Auto Scaling Group"
  value       = aws_autoscaling_group.backend.name
}

output "backend_asg_arn" {
  description = "ARN of the backend Auto Scaling Group"
  value       = aws_autoscaling_group.backend.arn
}

output "backend_scale_out_policy_arn" {
  description = "ARN of the backend target tracking scaling policy"
  value       = aws_autoscaling_policy.backend_scale_out.arn
}
