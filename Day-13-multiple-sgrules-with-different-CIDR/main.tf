# This Terraform configuration defines a security group with multiple ingress rules, each allowing access to different ports from specific CIDR blocks. The `allowed_ports` variable is a map that associates port numbers with their corresponding CIDR blocks, enabling flexible and granular control over network access.
variable "allowed_ports" {
  type = map(string)

  default = {
    "22"   = "203.0.113.0/24" # SSH access from a specific IP range
    "80"   = "0.0.0.0/0" # HTTP access from anywhere
    "443"  = "0.0.0.0/0" # HTTPS access from anywhere
    "8080" = "10.0.0.0/16" # Access to port 8080 from within the VPC
    "9000" = "192.168.1.0/24" # Access to port 9000 from a specific private network
    "3389" = "10.0.1.0/24" # RDP access from a specific subnet
    "3000" = "10.0.2.0/24" # Access to port 3000 from another specific subnet
  }
}

# This configuration creates two security groups with different ingress rules. The first security group allows access to multiple ports from anywhere, while the second security group allows access to specific ports from defined CIDR blocks.
resource "aws_security_group" "devops-project-test" {
  name        = "devops-project-test"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports

    content {
      description = "Allow access to port ${ingress.key}"
      from_port   = tonumber(ingress.key)
      to_port     = tonumber(ingress.key)
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-test"
  }
}