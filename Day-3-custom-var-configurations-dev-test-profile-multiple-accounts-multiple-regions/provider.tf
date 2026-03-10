provider "aws" {
    region = "ap-south-1" #Mumbai region
}
provider "aws" {
    region = "us-west-2" #Oregon region
    alias = "testenv"
    profile = "testuser"
}