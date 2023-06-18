module "iam_policy" {
    source = "../terraform_policy"
    policy_exists = var.policy_exists
    name_policy = "eks_master_policy"
    resource_name = "eks_master"
}

module "iam_role" {
    source = "../terraform_role"
    role_name = "master_role"
    name_policy = "eks_master_policy"
  
}
