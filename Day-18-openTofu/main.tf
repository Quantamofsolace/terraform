provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "name" {
  ami = "ami-0f559c3642608c138"
  instance_type = "t3.micro"
  tags = {
    Name = "openTofu"
  }
}

#this infra try and build with openTofu
#tofu init
#tofu plan
#tofu apply