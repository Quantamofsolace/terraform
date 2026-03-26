provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "name" {
  ami           = "ami-0f559c3642608c138"
  instance_type = "t3.small"
}

resource "aws_s3_bucket" "name" {
  bucket = "pooratthetemplestairsrichatthepalace"
}


#we can target specific resource to apply or destroy using -target option in terraform command
#terraform apply -target=aws_instance.name
#terraform destroy -target=aws_instance.name
#lifecycle block is used to control the behavior of resource creation, update and deletion
#skip option is used to ignore changes to specific attributes of a resource, so that terraform does not try to update the resource when those attributes change outside of terraform. This is useful for attributes that are managed by other tools or processes, or for attributes that are expected to change frequently and do not require manual intervention.
