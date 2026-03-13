resource "aws_instance" "name" {
    ami           = "ami-0f559c3642608c138"
    instance_type = "t3.micro"
    tags = {
        Name = "quantamofsoalce-hello"
    }
  
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "ewwwwww-haha-VPC"
    }
}

resource "aws_subnet" "name" {
    vpc_id     = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "ewwwwww-haha-Subnet"
    }
}