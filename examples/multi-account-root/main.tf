provider "aws" {
  region = "us-east-1"
  alias  = "parent"
}

provider "aws" {
  region = "us-east-1"
  alias  = "child"
  assume_role {
    role_arn = "arn:aws:iam::405675877343:role/OrganizationAccountAccessRole"
  }
}

module "multi_account_example" {
  source = "../../modules/multi-account"
  providers = {
    aws.parent = aws.parent
    aws.child  = aws.child
  }
}

output "parent_account_id" {
  value       = data.aws_caller_identity.parent.account_id
  description = "The ID of the parent AWS account"
}

output "child_account_id" {
  value       = data.aws_caller_identity.child.account_id
  description = "The ID of the child AWS account"
}
