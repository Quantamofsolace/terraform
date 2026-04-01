variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)"
  type        = string
}

variable "vpc_name" {
  description = "Name tag applied to the VPC and all derived resources"
  type        = string
}

# ── Public Subnets ──────────────────────────────────────────
variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet in AZ-1 (hosts bastion, frontend EC2, external ALB)"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet in AZ-2 (multi-AZ ALB requirement)"
  type        = string
}

# ── Private Web Subnets ─────────────────────────────────────
variable "private_subnet_1_cidr" {
  description = "CIDR for private web subnet in AZ-1 (frontend ASG instances)"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR for private web subnet in AZ-2 (frontend ASG instances)"
  type        = string
}

# ── Private App Subnets ─────────────────────────────────────
variable "private_subnet_3_cidr" {
  description = "CIDR for private app subnet in AZ-1 (backend ASG instances)"
  type        = string
}

variable "private_subnet_4_cidr" {
  description = "CIDR for private app subnet in AZ-2 (backend ASG instances)"
  type        = string
}

# ── Private DB Subnets ──────────────────────────────────────
variable "private_subnet_5_cidr" {
  description = "CIDR for private DB subnet in AZ-1 (RDS primary)"
  type        = string
}

variable "private_subnet_6_cidr" {
  description = "CIDR for private DB subnet in AZ-2 (RDS standby / Multi-AZ)"
  type        = string
}

# ── Availability Zones ──────────────────────────────────────
variable "availability_zone_1a" {
  description = "First availability zone (e.g. us-east-1a)"
  type        = string
}

variable "availability_zone_1b" {
  description = "Second availability zone (e.g. us-east-1b)"
  type        = string
}

# ── Security ────────────────────────────────────────────────
variable "allowed_ssh_cidr" {
  description = "List of CIDR blocks allowed SSH (port 22) access to the bastion host. Restrict to your IP in production."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
