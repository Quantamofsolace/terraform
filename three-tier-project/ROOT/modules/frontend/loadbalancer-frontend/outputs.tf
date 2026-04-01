output "alb_arn" {
  description = "ARN of the frontend Application Load Balancer"
  value       = aws_lb.front_end.arn
}

output "alb_dns_name" {
  description = "DNS name of the frontend ALB — this is the public URL users hit"
  value       = aws_lb.front_end.dns_name
}

output "alb_zone_id" {
  description = "Hosted zone ID of the frontend ALB — used to create Route 53 alias records"
  value       = aws_lb.front_end.zone_id
}

output "alb_target_group_arn" {
  description = "ARN of the frontend target group — attached to the frontend ASG"
  value       = aws_lb_target_group.front_end.arn
}

output "alb_target_group_name" {
  description = "Name of the frontend target group"
  value       = aws_lb_target_group.front_end.name
}
