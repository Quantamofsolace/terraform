# ═══════════════════════════════════════════════════════════════
#  TEST — variables.tf
#  Every variable that main.tf references via var.*
#  Values are set in terraform.tfvars — never hardcode here.
# ═══════════════════════════════════════════════════════════════

# ── AWS ────────────────────────────────────────────────────────
variable "aws_region" {
  description = "AWS region to deploy all resources"
  type        = string
}

# ── Project ────────────────────────────────────────────────────
variable "project_name" {
  description = "Project name prefix — used in resource names and tags"
  type        = string
}

# ── VPC / Networking ───────────────────────────────────────────
variable "vpc_name" {
  description = "Name tag for the VPC and all related networking resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet AZ-1 — bastion host and external ALB"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet AZ-2 — ALB requires 2 AZs"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR for private web subnet AZ-1 — frontend ASG instances"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR for private web subnet AZ-2 — frontend ASG instances"
  type        = string
}

variable "private_subnet_3_cidr" {
  description = "CIDR for private app subnet AZ-1 — backend ASG instances"
  type        = string
}

variable "private_subnet_4_cidr" {
  description = "CIDR for private app subnet AZ-2 — backend ASG instances"
  type        = string
}

variable "private_subnet_5_cidr" {
  description = "CIDR for private DB subnet AZ-1 — RDS primary node"
  type        = string
}

variable "private_subnet_6_cidr" {
  description = "CIDR for private DB subnet AZ-2 — RDS standby (Multi-AZ)"
  type        = string
}

variable "availability_zone_1a" {
  description = "First availability zone (e.g. us-east-1a)"
  type        = string
}

variable "availability_zone_1b" {
  description = "Second availability zone (e.g. us-east-1b)"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed SSH access to the bastion host. Restrict to your IP in production."
  type        = list(string)
}

# ── EC2 ────────────────────────────────────────────────────────
variable "ami" {
  description = "AMI ID for EC2 instances — must match the selected aws_region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for golden instances (e.g. t2.micro, t3.small)"
  type        = string
}

variable "lt_instance_type" {
  description = "EC2 instance type used in the launch template for ASG instances"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name for SSH access — must already exist in AWS"
  type        = string
}

# ── ALB ────────────────────────────────────────────────────────
variable "frontend_alb_name" {
  description = "Name of the frontend Application Load Balancer"
  type        = string
}

variable "frontend_tg_name" {
  description = "Name of the frontend ALB target group"
  type        = string
}

variable "backend_alb_name" {
  description = "Name of the backend Application Load Balancer"
  type        = string
}

variable "backend_tg_name" {
  description = "Name of the backend ALB target group"
  type        = string
}

# ── RDS ────────────────────────────────────────────────────────
variable "db_identifier" {
  description = "Unique RDS instance identifier (shown in AWS Console)"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "db_engine" {
  description = "Database engine (e.g. mysql, postgres)"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version (e.g. 8.0)"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class (e.g. db.t3.micro)"
  type        = string
}

variable "db_multi_az" {
  description = "Enable Multi-AZ RDS deployment for high availability"
  type        = bool
}

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the RDS instance — use Secrets Manager in production"
  type        = string
  sensitive   = true
}

# ── ASG — Frontend ─────────────────────────────────────────────
variable "frontend_desired_capacity" {
  description = "Desired number of frontend instances in the ASG"
  type        = number
}

variable "frontend_min_size" {
  description = "Minimum number of frontend instances in the ASG"
  type        = number
}

variable "frontend_max_size" {
  description = "Maximum number of frontend instances the ASG can scale to"
  type        = number
}

variable "frontend_scale_out_cpu" {
  description = "Target CPU utilization % that triggers frontend scale-out"
  type        = number
}

# ── ASG — Backend ──────────────────────────────────────────────
variable "backend_desired_capacity" {
  description = "Desired number of backend instances in the ASG"
  type        = number
}

variable "backend_min_size" {
  description = "Minimum number of backend instances in the ASG"
  type        = number
}

variable "backend_max_size" {
  description = "Maximum number of backend instances the ASG can scale to"
  type        = number
}

variable "backend_scale_out_cpu" {
  description = "Target CPU utilization % that triggers backend scale-out"
  type        = number
}
