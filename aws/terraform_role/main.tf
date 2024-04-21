resource "aws_iam_role" "aws_iam_role" {
    name = var.role_name
    assume_role_policy = file("../policies/${var.name_policy}.json")
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  count = var.num
  policy_arn = var.permission_policy[count.index]
  role       = aws_iam_role.aws_iam_role.name
}
