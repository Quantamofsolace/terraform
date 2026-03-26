provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "name" {
  ami           = "ami-0f559c3642608c138"
  instance_type = "t3.small"

  tags = {
    Name = "haaa"
  }
  lifecycle {
    ignore_changes = [ tags ]
  }
#   lifecycle {
#     prevent_destroy = true
  }

#   lifecycle {
#     create_before_destroy = true
  

