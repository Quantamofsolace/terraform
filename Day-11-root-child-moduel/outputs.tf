output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_1_id" {
  description = "Subnet 1 ID"
  value       = module.vpc.subnet_1_id
}

output "subnet_2_id" {
  description = "Subnet 2 ID"
  value       = module.vpc.subnet_2_id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = module.rds.rds_endpoint
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = module.s3.bucket_name
}

output "lambda_function_name" {
  description = "Lambda Function Name"
  value       = module.lambda.function_name
}
