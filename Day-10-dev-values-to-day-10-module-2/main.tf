provider "aws" {
    region = "ap-south-1"
  
}


module "dev" {
    source = "../Day-10-module-2"
    ami_id = "ami-0f559c3642608c138"
    instance_type = "t3.micro"

  
}