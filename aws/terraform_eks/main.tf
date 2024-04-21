# module "iam_policy" {
#     source = "../terraform_policy"
#     policy_exists = var.policy_exists
#     name_policy = "eks_master_policy"
#     resource_name = "eks_master"
# }

module "iam_role_eks_master" {
    source = "../terraform_role"
    num = 1
    role_name = var.role_name
    name_policy = "eks_master_policy"
    permission_policy = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
    region = "us-east-1"
  
}


resource "aws_eks_cluster" "eks_master" {

   name = var.eks_name
   role_arn = module.iam_role_eks_master.iam_role_arn
   version = "1.27"
   vpc_config {
 
        endpoint_public_access = true
        subnet_ids = concat(var.public_subnet_ids[*], var.private_subnet_ids[*])
        

   }

   depends_on = [ module.iam_role_eks_master.iam_role_arn ]

}

module "iam_role_nodegroup" {
    source = "../terraform_role"
    num = 3
    role_name = var.instance_group_role
    name_policy = "eks_node_group_policy"
    permission_policy = var.permissions[*]
    region = "us-east-1"
  
}

resource "aws_eks_node_group" "eks_node_group" {
    
    cluster_name = aws_eks_cluster.eks_master.name
    node_group_name = var.instance_group
    node_role_arn = module.iam_role_nodegroup.iam_role_arn
    subnet_ids = var.private_subnet_ids[*]
    scaling_config {
       
       desired_size = 1
       max_size = 3
       min_size = 1

    }
    capacity_type = "ON_DEMAND"
    disk_size = var.size
    instance_types = [var.type]

    depends_on = [ module.iam_role_nodegroup.iam_role_arn ]
}

