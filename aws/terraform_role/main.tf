resource "aws_iam_role" "aws_iam_role" {
    name = var.role_name
    assume_role_policy = file("../policies/${var.name_policy}.json")
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  policy_arn = aws_iam_role.aws_iam_role.arn
  role       = aws_iam_role.aws_iam_role.name
}