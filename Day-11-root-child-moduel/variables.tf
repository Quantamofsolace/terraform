variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_1_cidr" {
  description = "CIDR block for subnet 1"
  type        = string
}

variable "subnet_2_cidr" {
  description = "CIDR block for subnet 2"
  type        = string
}

variable "az1" {
  description = "Availability zone for subnet 1"
  type        = string
}

variable "az2" {
  description = "Availability zone for subnet 2"
  type        = string
}
