# Terraform Output Values
output "aws_vpc" {
  description = "VPC identity"
  value = aws_vpc.aws_vpc.id
}

output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.myec2vm.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = aws_instance.myec2vm.public_dns
}