# Terraform Output Values
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.myec2vm.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value       = aws_instance.myec2vm.public_dns
}
output "key_content" {
  description = "EC2 Instance key content"
  value       = local_file.ec2_key_file.content
}