resource "aws_instance" "name" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "name-Instance"
  }

}

resource "aws_instance" "hello" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "hello-Instance-2"
  }

}