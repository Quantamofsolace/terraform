provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "name" {
  ami = "ami-0931307dcdc2a28c9"
    instance_type = "t3.micro"
    tags = {
        Name = "test"
    }
}

resource "aws_s3_bucket" "bucket" {
    bucket = "feelinggoodmix"
    
    
}
resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Disabled"
  }
  
  }
