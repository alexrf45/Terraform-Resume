output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "The ARNS of the created IAM users"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}

output "for_directive" {
  value = "%{for name in var.user_names}${name}, %{endfor}"
}

output "neo_cloudwatch_policy_arn" {
  value = one(concat(
    aws_iam_user_policy_attachment.neo_cloudwatch_full_access[*].policy_arn,
    aws_iam_user_policy_attachment.neo_cloudwatch_read_only[*].policy_arn
  ))
}
