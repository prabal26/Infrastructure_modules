variable "aws_vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}
variable "private_aws_subnet_ranges" {
    type = list(string)
    default = ["10.0.0.0/24","10.0.1.0/24"]
}
variable "public_aws_subnet_ranges" {
    type = list(string)
    default = ["10.0.2.0/24","10.0.3.0/24"]
  
}