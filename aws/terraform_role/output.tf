output "iam_role_arn" {
  description = "The ARN of the IAM role created by the module."
  value       = aws_iam_role.aws_iam_role.arn
}