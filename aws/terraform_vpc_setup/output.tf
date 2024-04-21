output "aws_vpc" {
  description = "output vpc id"
  value       = aws_vpc.aws_vpc
}

# output "public_ip" {
#   value = module.ec2_module.instance_publicip
#   default = "None"
# }

