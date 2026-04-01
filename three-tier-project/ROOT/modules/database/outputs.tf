output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.book-rds.id
}

output "db_endpoint" {
  description = "RDS connection endpoint (host:port) — use this in your app's DB_HOST config"
  value       = aws_db_instance.book-rds.endpoint
}

output "db_address" {
  description = "RDS hostname only (without port)"
  value       = aws_db_instance.book-rds.address
}

output "db_port" {
  description = "RDS port"
  value       = aws_db_instance.book-rds.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.book-rds.db_name
}

output "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  value       = aws_db_subnet_group.rds-db-group.name
}
