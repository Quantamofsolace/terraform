

provider "aws" {
  region = "ap-south-1"

}



# resource "aws_instance" "dev" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   count         = 2
# #   tags = {
# #     Name = "dev-instance" #so here we are creating 2 instances with same name
# #   }
#        tags = {
#           Name = "dev-instance-${count.index}"  #so here we are creating 2 instances with different name
#   }
# }



resource "aws_instance" "name" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = length(var.env)
  tags = {
    Name = var.env[count.index] #so here we are creating 2 instances with different name

  }
}