resource "aws_iam_policy" "aws_iam_policy" {
    count = (var.policy_exists == true) ? 1 : 0
    name = "${var.resource_name}"
    policy = file("../policies/${var.name_policy}.json")

}

