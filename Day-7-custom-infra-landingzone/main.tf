#creation of VPC, subnet, internet gateway, route table, security group, and EC2 instance
resource "aws_vpc" "demo_vpc" { #creation of VPC
  cidr_block = "10.0.0.0/16"    #CIDR block for the VPC
  tags = {                      #tagging the VPC
    Name = "demo_vpc"           #name tag for the VPC
  }
}
#creation of two subnets in different availability zones this is the first one.
resource "aws_subnet" "demo_subnet" {     #creation of first subnet in availability zone ap-south-1a
  vpc_id            = aws_vpc.demo_vpc.id #associate the subnet with the VPC
  cidr_block        = "10.0.1.0/24"       #CIDR block for the subnet
  availability_zone = "ap-south-1a"       #availability zone for the subnet
  tags = {                                #tagging the subnet
    Name = "demo_subnet"                  #name tag for the subnet
  }
}
#creation of second subnet in different availability zone
resource "aws_subnet" "demo_subnet2" {    #creation of second subnet in availability zone ap-south-1b
  vpc_id            = aws_vpc.demo_vpc.id #associate the subnet with the VPC
  cidr_block        = "10.0.2.0/24"       #CIDR block for the subnet
  availability_zone = "ap-south-1b"       #availability zone for the subnet
  tags = {                                #tagging the subnet
    Name = "demo_subnet2"                 #name tag for the subnet
  }
}
#creation of internet gateway and attaching it to the VPC
resource "aws_internet_gateway" "demo_igw" { #creation of internet gateway
  vpc_id = aws_vpc.demo_vpc.id               #attach the IGW to the VPC
  tags = {                                   #tagging the IGW
    Name = "demo_igw"                        #name tag for the IGW
  }
}                                                 #creation of route table and associating it with the subnets
resource "aws_route_table" "demo_route_table" {   #creation of route table
  vpc_id = aws_vpc.demo_vpc.id                    #associate the route table with the VPC
  route {                                         #creation of route to allow internet access
    cidr_block = "0.0.0.0/0"                      #destination for the route (all traffic)
    gateway_id = aws_internet_gateway.demo_igw.id #target for the route (the internet gateway)

  }
  tags = {                    #tagging the route table
    Name = "demo_route_table" #name tag for the route table
  }
}
#associating the route table with the subnets
resource "aws_route_table_association" "demo_route_table_association" { #associating the route table with the first subnet
  subnet_id      = aws_subnet.demo_subnet.id                            #associate the route table with the first subnet
  route_table_id = aws_route_table.demo_route_table.id                  #associate the route table with the first subnet
}
#associating the route table with the second subnet
resource "aws_route_table_association" "demo_route_table_association2" { #associating the route table with the second subnet
  subnet_id      = aws_subnet.demo_subnet2.id                            #associate the route table with the second subnet
  route_table_id = aws_route_table.demo_route_table.id                   #associate the route table with the second subnet
}
#creation of security group and EC2 instance
resource "aws_security_group" "demo_sg" { #creation of security group
  name        = "demo_sg"                 #name of the security group
  description = "Allow SSH and HTTP"      #description of the security group
  vpc_id      = aws_vpc.demo_vpc.id       #associate the security group with the VPC
  ingress {                               #ingress rule to allow SSH access
    from_port   = 22                      #port for SSH
    to_port     = 22                      #port for SSH
    protocol    = "tcp"                   #protocol for SSH
    cidr_blocks = ["0.0.0.0/0"]           #allow SSH access from anywhere
  }
  egress {                      #egress rule to allow all outbound traffic
    from_port   = 0             #allow all outbound traffic
    to_port     = 0             #allow all outbound traffic
    protocol    = "-1"          #allow all protocols
    cidr_blocks = ["0.0.0.0/0"] #allow all outbound traffic to anywhere
  }
}
resource "aws_instance" "demo_instance" {                       #creation of EC2 instance
  ami                         = "ami-0f559c3642608c138"         # Amazon Linux 2 AMI
  instance_type               = "t3.micro"                      #instance type for the EC2 instance
  subnet_id                   = aws_subnet.demo_subnet.id       #launch the EC2 instance in the first subnet
  associate_public_ip_address = true                            #associate a public IP address with the EC2 instance
  vpc_security_group_ids      = [aws_security_group.demo_sg.id] #associate the security group with the EC2 instance
  tags = {                                                      #tagging the EC2 instance
    Name = "demo_instance1"                                     #name tag for the EC2 instance
  }
}