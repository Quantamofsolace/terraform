output "alb_arn" {
  description = "ARN of the backend Application Load Balancer"
  value       = aws_lb.back_end.arn
}

output "alb_dns_name" {
  description = "DNS name of the backend ALB — used by frontend Nginx proxy_pass"
  value       = aws_lb.back_end.dns_name
}

output "alb_zone_id" {
  description = "Hosted zone ID of the backend ALB — used to create Route 53 alias records"
  value       = aws_lb.back_end.zone_id
}

output "alb_target_group_arn" {
  description = "ARN of the backend target group — attached to the backend ASG"
  value       = aws_lb_target_group.back_end.arn
}

output "alb_target_group_name" {
  description = "Name of the backend target group"
  value       = aws_lb_target_group.back_end.name
}
