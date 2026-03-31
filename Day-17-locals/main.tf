locals {
  region        = "ap-south-1"
  instance_type = "t3t.micro"
  ami_id= "ami-0f559c3642608c138"
}

resource "aws_instance" "name" {
  ami = local.ami_id
  instance_type = local.instance_type
  region = local.region
}