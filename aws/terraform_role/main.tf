resource "aws_iam_role" "aws_iam_role" {
    name = var.role_name
    assume_role_policy = file("../policies/${var.name_policy}.json")
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws_iam_role.name
}
resource "aws_iam_role_policy_attachment" "kubernetes_service_policy_attachment" {
  role       = aws_iam_role.aws_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}