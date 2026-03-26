output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.mysql.id
}
