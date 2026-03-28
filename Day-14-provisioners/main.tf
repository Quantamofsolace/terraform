# -----------------------------
# Generate SSH Key (AUTO)
# -----------------------------
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.generated.private_key_pem
  filename = "saltandpepper.pem"
}

# Create AWS Key Pair using generated key
resource "aws_key_pair" "example" {
  key_name   = "saltandpepper-new"
  public_key = tls_private_key.generated.public_key_openssh
}

# -----------------------------
# VPC
# -----------------------------
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# -----------------------------
# Subnet
# -----------------------------
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

# -----------------------------
# Internet Gateway
# -----------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

# -----------------------------
# Route Table
# -----------------------------
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# -----------------------------
# Route Table Association
# -----------------------------
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH (change to your IP)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 🔒 replace with your IP for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# EC2 Instance
# -----------------------------
resource "aws_instance" "server" {
  ami                         = "ami-05d2d839d4f73aafb"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.example.key_name
  subnet_id                   = aws_subnet.sub1.id
  vpc_security_group_ids      = [aws_security_group.webSg.id]
  associate_public_ip_address = true

  tags = {
    Name = "UbuntuServer"
  }

  # SSH connection
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
    timeout     = "2m"
  }

  # Copy file
  provisioner "file" {
    source      = "file10"
    destination = "/home/ubuntu/file10"
  }

  # Remote commands
  provisioner "remote-exec" {
    inline = [
      "touch /home/ubuntu/file200",
      "echo 'hello from veera nareshit hyd' >> /home/ubuntu/file200"
    ]
  }

  # Local command
  provisioner "local-exec" {
    command = "touch file500"
  }
}

resource "null_resource" "run_script" {

  # ✅ Ensure EC2 is created first
  depends_on = [aws_instance.server]

  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      host        = aws_instance.server.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.generated.private_key_pem # ✅ full path
      timeout     = "2m"
    }

    inline = [
      "echo 'hello from veeranareshithyd' >> /home/ubuntu/file200"
    ]
  }

  # ✅ Trigger only when script changes
  triggers = {
    script_hash = filemd5("script.sh")
  }
}