variable "ami_id" {
  description = "need to pass the ec2 ami"
  default     = ""
  type        = string

}
variable "instance_type" {
  description = "need to pass the ec2 instance type"
  default     = ""
  type        = string
}
variable "env" {
  description = "environment name"
  default     = ["dev", "prod"]
  type        = list(string)
}