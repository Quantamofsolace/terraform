# ─────────────────────────────────────────────
# VPC
# ─────────────────────────────────────────────
output "vpc_id" {
  description = "ID of the created VPC — passed to all other modules"
  value       = aws_vpc.three_tier.id
}

# ─────────────────────────────────────────────
# Subnets
# ─────────────────────────────────────────────
output "public_subnets" {
  description = "List of public subnet IDs (AZ-1a, AZ-1b) — used by bastion, frontend EC2, and ALBs"
  value       = [aws_subnet.pub1.id, aws_subnet.pub2.id]
}

output "private_web_subnets" {
  description = "List of private web subnet IDs (AZ-1a, AZ-1b) — reserved for future web-tier ASG"
  value       = [aws_subnet.prvt3.id, aws_subnet.prvt4.id]
}

output "private_app_subnets" {
  description = "List of private app subnet IDs (AZ-1a, AZ-1b) — used by backend ASG"
  value       = [aws_subnet.prvt5.id, aws_subnet.prvt6.id]
}

output "private_db_subnets" {
  description = "List of private DB subnet IDs (AZ-1a, AZ-1b) — used by RDS subnet group"
  value       = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
}

# ─────────────────────────────────────────────
# Gateways
# ─────────────────────────────────────────────
output "igw_id" {
  description = "Internet Gateway ID attached to the VPC"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID — allows private subnets to reach the internet for updates/installs"
  value       = aws_nat_gateway.nat.id
}

output "nat_gateway_public_ip" {
  description = "Public IP of the NAT Gateway — whitelist this in external firewalls if needed"
  value       = aws_eip.nat_eip.public_ip
}

# ─────────────────────────────────────────────
# Security Group IDs — consumed by downstream modules
# ─────────────────────────────────────────────
output "bastion_sg_id" {
  description = "Security Group ID for the Bastion Host (SSH from allowed CIDRs)"
  value       = aws_security_group.bastion_host.id
}

output "alb_frontend_sg_id" {
  description = "Security Group ID for the Frontend ALB (HTTP/HTTPS from internet)"
  value       = aws_security_group.alb_frontend.id
}

output "alb_backend_sg_id" {
  description = "Security Group ID for the Backend ALB (HTTP/HTTPS internal)"
  value       = aws_security_group.alb_backend.id
}

output "frontend_server_sg_id" {
  description = "Security Group ID for Frontend EC2/ASG instances"
  value       = aws_security_group.frontend_server.id
}

output "backend_server_sg_id" {
  description = "Security Group ID for Backend EC2/ASG instances"
  value       = aws_security_group.backend_server.id
}

output "database_sg_id" {
  description = "Security Group ID for RDS (MySQL 3306 from backend servers)"
  value       = aws_security_group.database.id
}
