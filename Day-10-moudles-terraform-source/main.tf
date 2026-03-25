module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  region = "ap-south-1"

  name = "single-instance"

  instance_type = "t3.micro"
  key_name      = "user1"
  monitoring    = true
  subnet_id     = "subnet-0a2d2ab965dc66674"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
