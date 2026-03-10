variable "dev_ami_id" {
  description = "AMI ID for DEV instance"
  type        = string
}

variable "dev_instance_type" {
  description = "Instance type for DEV EC2"
  type        = string
}

variable "test_ami_id" {
  description = "AMI ID for TEST instance"
  type        = string
}

variable "test_instance_type" {
  description = "Instance type for TEST EC2"
  type        = string
}