# ═══════════════════════════════════════════════════════════════
#  THREE-TIER APP — DEV ENVIRONMENT OUTPUTS
#
#  After terraform apply, run:
#    terraform output                  → show all outputs
#    terraform output frontend_alb_dns → show single value
# ═══════════════════════════════════════════════════════════════

# ─── Networking ───────────────────────────────────────────────
output "vpc_id" {
  description = "ID of the dev VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs — bastion host and ALBs run here"
  value       = module.vpc.public_subnets
}

output "private_app_subnet_ids" {
  description = "Private app subnet IDs — backend ASG instances run here"
  value       = module.vpc.private_app_subnets
}

output "private_db_subnet_ids" {
  description = "Private DB subnet IDs — RDS runs here, no internet route"
  value       = module.vpc.private_db_subnets
}

output "nat_gateway_public_ip" {
  description = "Egress IP for all private resources — whitelist in external services if needed"
  value       = module.vpc.nat_gateway_public_ip
}

# ─── Security Groups ──────────────────────────────────────────
output "bastion_sg_id" {
  description = "Bastion host security group ID"
  value       = module.vpc.bastion_sg_id
}

output "frontend_server_sg_id" {
  description = "Frontend server security group ID"
  value       = module.vpc.frontend_server_sg_id
}

output "backend_server_sg_id" {
  description = "Backend server security group ID"
  value       = module.vpc.backend_server_sg_id
}

output "database_sg_id" {
  description = "Database security group ID"
  value       = module.vpc.database_sg_id
}

# ─── Bastion Host ─────────────────────────────────────────────
output "bastion_public_ip" {
  description = "SSH entry point: ssh -i key.pem ec2-user@<bastion_public_ip>"
  value       = module.bastion.bastion_public_ip
}

output "bastion_instance_id" {
  description = "Bastion EC2 instance ID"
  value       = module.bastion.bastion_instance_id
}

# ─── Golden Instances (pre-AMI baking) ────────────────────────
output "frontend_golden_instance_id" {
  description = "Frontend golden EC2 instance ID — source for AMI baking"
  value       = module.frontend_ec2.frontend_instance_id
}

output "frontend_golden_public_ip" {
  description = "Frontend golden instance public IP — SSH to configure, then bake AMI"
  value       = module.frontend_ec2.frontend_public_ip
}

output "backend_golden_instance_id" {
  description = "Backend golden EC2 instance ID — source for AMI baking"
  value       = module.backend_ec2.backend_instance_id
}

output "backend_golden_public_ip" {
  description = "Backend golden instance public IP"
  value       = module.backend_ec2.backend_public_ip
}

# ─── AMIs (created by launch-template module) ─────────────────
output "frontend_ami_id" {
  description = "AMI ID baked from the frontend golden instance — used in launch template"
  value       = module.frontend_launchtemplate.frontend_ami_id
}

output "backend_ami_id" {
  description = "AMI ID baked from the backend golden instance — used in launch template"
  value       = module.backend_launchtemplate.backend_ami_id
}

# ─── Load Balancers ───────────────────────────────────────────
output "frontend_alb_dns" {
  description = "Frontend ALB DNS — open in browser to reach the app"
  value       = module.frontend_alb.alb_dns_name
}

output "frontend_alb_arn" {
  description = "Frontend ALB ARN"
  value       = module.frontend_alb.alb_arn
}

output "frontend_target_group_arn" {
  description = "Frontend ALB target group ARN — attached to frontend ASG"
  value       = module.frontend_alb.alb_target_group_arn
}

output "backend_alb_dns" {
  description = "Backend ALB DNS — used in frontend Nginx proxy_pass directive"
  value       = module.backend_alb.alb_dns_name
}

output "backend_alb_arn" {
  description = "Backend ALB ARN"
  value       = module.backend_alb.alb_arn
}

output "backend_target_group_arn" {
  description = "Backend ALB target group ARN — attached to backend ASG"
  value       = module.backend_alb.alb_target_group_arn
}

# ─── RDS ──────────────────────────────────────────────────────
output "rds_endpoint" {
  description = "Full RDS endpoint (host:port) — set as DB_HOST in your app .env"
  value       = module.rds.db_endpoint
}

output "rds_address" {
  description = "RDS hostname only (without port)"
  value       = module.rds.db_address
}

output "rds_port" {
  description = "RDS port — 3306 for MySQL"
  value       = module.rds.db_port
}

output "rds_db_name" {
  description = "RDS database name"
  value       = module.rds.db_name
}

output "rds_instance_id" {
  description = "RDS instance identifier"
  value       = module.rds.db_instance_id
}

# ─── Auto Scaling Groups ──────────────────────────────────────
output "frontend_asg_name" {
  description = "Frontend ASG name — use to check instances in EC2 console"
  value       = module.asg_frontend.frontend_asg_name
}

output "frontend_asg_arn" {
  description = "Frontend ASG ARN"
  value       = module.asg_frontend.frontend_asg_arn
}

output "backend_asg_name" {
  description = "Backend ASG name"
  value       = module.asg_backend.backend_asg_name
}

output "backend_asg_arn" {
  description = "Backend ASG ARN"
  value       = module.asg_backend.backend_asg_arn
}
