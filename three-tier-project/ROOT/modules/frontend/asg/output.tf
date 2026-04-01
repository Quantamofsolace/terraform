output "frontend_asg_name" {
  description = "Name of the frontend Auto Scaling Group"
  value       = aws_autoscaling_group.frontend.name
}

output "frontend_asg_arn" {
  description = "ARN of the frontend Auto Scaling Group"
  value       = aws_autoscaling_group.frontend.arn
}

output "frontend_scale_out_policy_arn" {
  description = "ARN of the frontend target tracking scaling policy"
  value       = aws_autoscaling_policy.frontend_scale_out.arn
}
