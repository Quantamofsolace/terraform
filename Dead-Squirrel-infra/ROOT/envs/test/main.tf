# ═══════════════════════════════════════════════════════════════
#  THREE-TIER APP — TEST ENVIRONMENT
#
#  Usage:
#    cd ROOT/envs/test
#    terraform init
#    terraform plan  -var-file="terraform.tfvars"
#    terraform apply -var-file="terraform.tfvars"
#
#  All values come from terraform.tfvars — no hardcoded values here.
# ═══════════════════════════════════════════════════════════════

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "s3" {
  #   bucket         = "your-tfstate-bucket-name"
  #   key            = "three-tier/test/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }
}

provider "aws" {
  region = var.aws_region
}

# ─────────────────────────────────────────────────────────────
# VPC + Subnets + Route Tables + NAT Gateway + Security Groups
# ─────────────────────────────────────────────────────────────
module "vpc" {
  source = "../../modules/infrastructure"

  aws_region            = var.aws_region
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  private_subnet_3_cidr = var.private_subnet_3_cidr
  private_subnet_4_cidr = var.private_subnet_4_cidr
  private_subnet_5_cidr = var.private_subnet_5_cidr
  private_subnet_6_cidr = var.private_subnet_6_cidr
  availability_zone_1a  = var.availability_zone_1a
  availability_zone_1b  = var.availability_zone_1b
  allowed_ssh_cidr      = var.allowed_ssh_cidr
}

# ─────────────────────────────────────────────────────────────
# Bastion Host — SSH jump server in public subnet
# ─────────────────────────────────────────────────────────────
module "bastion" {
  source = "../../modules/bastion"

  aws_region        = var.aws_region
  project_name      = var.project_name
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnets[0]
  security_group_id = module.vpc.bastion_sg_id
}

# ─────────────────────────────────────────────────────────────
# Frontend EC2 — golden instance used to bake the frontend AMI
# ─────────────────────────────────────────────────────────────
module "frontend_ec2" {
  source = "../../modules/frontend/ec2"

  aws_region        = var.aws_region
  project_name      = var.project_name
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnets[0]
  security_group_id = module.vpc.frontend_server_sg_id
}

# ─────────────────────────────────────────────────────────────
# Backend EC2 — golden instance used to bake the backend AMI
# ─────────────────────────────────────────────────────────────
module "backend_ec2" {
  source = "../../modules/backend/ec2"

  aws_region        = var.aws_region
  project_name      = var.project_name
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnets[0]
  security_group_id = module.vpc.backend_server_sg_id
}

# ─────────────────────────────────────────────────────────────
# Frontend ALB — internet-facing, routes to frontend ASG
# ─────────────────────────────────────────────────────────────
module "frontend_alb" {
  source = "../../modules/frontend/loadbalancer-frontend"

  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  subnets           = module.vpc.public_subnets
  security_group_id = module.vpc.alb_frontend_sg_id
  alb_name          = var.frontend_alb_name
  target_group_name = var.frontend_tg_name
}

# ─────────────────────────────────────────────────────────────
# Backend ALB — routes traffic to backend ASG
# ─────────────────────────────────────────────────────────────
module "backend_alb" {
  source = "../../modules/backend/loadbalancer-backend"

  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  subnets           = module.vpc.public_subnets
  security_group_id = module.vpc.alb_backend_sg_id
  alb_name          = var.backend_alb_name
  target_group_name = var.backend_tg_name
}

# ─────────────────────────────────────────────────────────────
# RDS MySQL — single AZ for test (cost saving)
# ─────────────────────────────────────────────────────────────
module "rds" {
  source = "../../modules/database"

  aws_region        = var.aws_region
  project_name      = var.project_name
  identifier        = var.db_identifier
  allocated_storage = var.db_allocated_storage
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  multi_az          = var.db_multi_az
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_subnet_1_id    = module.vpc.private_db_subnets[0]
  db_subnet_2_id    = module.vpc.private_db_subnets[1]
  rds_sg_id         = module.vpc.database_sg_id
}

# ─────────────────────────────────────────────────────────────
# Frontend Launch Template
# ─────────────────────────────────────────────────────────────
module "frontend_launchtemplate" {
  source = "../../modules/frontend/launch-template"

  aws_region     = var.aws_region
  project_name   = var.project_name
  instance_type  = var.lt_instance_type
  frontend_sg_id = module.vpc.frontend_server_sg_id
  key_name       = var.key_name
  instanceid     = module.frontend_ec2.frontend_instanceid
}

# ─────────────────────────────────────────────────────────────
# Backend Launch Template
# ─────────────────────────────────────────────────────────────
module "backend_launchtemplate" {
  source = "../../modules/backend/launch-template"

  aws_region    = var.aws_region
  project_name  = var.project_name
  instance_type = var.lt_instance_type
  backend_sg_id = module.vpc.backend_server_sg_id
  key_name      = var.key_name
  instanceid    = module.backend_ec2.backend_instanceid
}

# ─────────────────────────────────────────────────────────────
# Frontend ASG
# ─────────────────────────────────────────────────────────────
module "asg_frontend" {
  source = "../../modules/frontend/asg"

  aws_region                  = var.aws_region
  project_name                = var.project_name
  frontend_launch_template_id = module.frontend_launchtemplate.frontend_launch_template_id
  web_subnet_1_id             = module.vpc.public_subnets[0]
  web_subnet_2_id             = module.vpc.public_subnets[1]
  frontend_target_group_arn   = module.frontend_alb.alb_target_group_arn
  frontend_desired_capacity   = var.frontend_desired_capacity
  frontend_min_size           = var.frontend_min_size
  frontend_max_size           = var.frontend_max_size
  scale_out_target_value      = var.frontend_scale_out_cpu
}

# ─────────────────────────────────────────────────────────────
# Backend ASG
# ─────────────────────────────────────────────────────────────
module "asg_backend" {
  source = "../../modules/backend/asg"

  aws_region                 = var.aws_region
  project_name               = var.project_name
  backend_launch_template_id = module.backend_launchtemplate.backend_launch_template_id
  app_subnet_1_id            = module.vpc.private_app_subnets[0]
  app_subnet_2_id            = module.vpc.private_app_subnets[1]
  backend_target_group_arn   = module.backend_alb.alb_target_group_arn
  backend_desired_capacity   = var.backend_desired_capacity
  backend_min_size           = var.backend_min_size
  backend_max_size           = var.backend_max_size
  scale_out_target_value     = var.backend_scale_out_cpu
}
