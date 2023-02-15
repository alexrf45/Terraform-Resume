output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "The ARNS of the created IAM users"
  }

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
  }

output "for_directive" {
  value = "%{ for name in var.user_names  }${name}, %{ endfor }"
  }
