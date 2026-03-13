terraform {
  backend "s3" {
    bucket = "feelinggoodmix"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
