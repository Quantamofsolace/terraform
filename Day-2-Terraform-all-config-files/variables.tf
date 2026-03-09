variable "ami_id" {
  description = "This variable is used to specify the AMI ID for the EC2 instance."
  default     = ""
  type        = string


}
variable "instance_type" {
  description = "This variable is used to specify the instance type for the EC2 instance."
  default     = ""
  type        = string

}