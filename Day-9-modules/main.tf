#wanted to pass values from day-9 to day-2 so souce code exist in day2.action

module "name" {
  source        = "../Day-2-Terraform-all-config-files"
  ami_id        = "ami-0f559c3642608c138"
  instance_type = "t3.small"
}
