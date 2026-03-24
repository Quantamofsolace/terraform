provider "aws" {
  region = "ap-south-1"

}

 #############################
 ## // creation of instance ##
 ##                         ##
 #############################
resource "aws_instance" "name" {
  ami           = "ami-0f559c3642608c138"
  instance_type = "t3.micro"
  tags = {
    Name = "MyFirstInstance"
  }
  iam_instance_profile = aws_iam_instance_profile.name.name

  # This will ensure that the EC2 instance is created only after the S3 bucket is created.
  depends_on = [aws_iam_instance_profile.name]

}
resource "aws_s3_bucket" "name" {
  bucket = "my-first-bucket-1234567890"

}

resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

#attach the AmazonS3ReadOnlyAccess policy to the IAM role
resource "aws_iam_role_policy_attachment" "ec2_s3_role_attachment" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
#create an instance profile and attach the IAM role to it
resource "aws_iam_instance_profile" "name" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}


#dependency block is used to specify that the EC2 instance should be created only after the S3 bucket and IAM role are created. This ensures that the necessary resources are in place before the EC2 instance is launched.


