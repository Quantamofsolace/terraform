output "function_name" {
  description = "Lambda Function Name"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "Lambda Function ARN"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "Lambda Invoke ARN (used for API Gateway)"
  value       = aws_lambda_function.this.invoke_arn
}
