variable "dev" {
  type    = bool
  default = false
}

resource "aws_instance" "name" {
  ami           = "ami-06c643a49c853da56"
  instance_type = "t3.micro"
  count         = var.dev ? 1 : 0
}
#if dev is true then 1 instance will be created otherwise 0 instance will be created