output "user_arn" {
  value       = aws_iam_user.example[*].arn
  description = "The ARN of the created IAM user"
}

output "name" {
  value       = aws_iam_user.example.name
  description = "The name of the created IAM user"

}
