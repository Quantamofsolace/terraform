output "public_ip_name" {
  value = aws_instance.name.public_ip
}
output "private_ip_name" {
  value = aws_instance.name.private_ip
}
output "public_ip_hello" {
  value = aws_instance.hello.public_ip
}
output "private_ip_hello" {
  value = aws_instance.hello.private_ip
}