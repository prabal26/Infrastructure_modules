variable "policy_exists" {
    type = bool
    default = false
}
variable "vpcid"{
    type = string
}
variable "eks_name"{
    type = string
}
variable "public_subnet_ids" {
    type = list(string)
}
variable "private_subnet_ids" {
    type = list(string)
}
variable "role_name" {
    type = string
}
variable "instance_group" {
    type = string
}
variable "instance_group_role" {
    type = string
}
variable "permissions" {
    type = list(string)
    default = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy","arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy","arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
}
variable "size"{
    type = number
}
variable "type"{
    type = string
}
