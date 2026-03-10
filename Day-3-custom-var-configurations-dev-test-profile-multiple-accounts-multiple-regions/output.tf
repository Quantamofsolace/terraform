output "public_ip_dev" {
  value = aws_instance.dev.public_ip
}
output "private_ip_dev" {
  value = aws_instance.dev.private_ip
}
output "public_ip_test" {
  value = aws_instance.test.public_ip
}
output "private_ip_test" {
  value = aws_instance.test.private_ip
}