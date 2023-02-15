provider "aws" {
  region = "us-east-2"
}

module "users" {
  #source = "../../../modules/landing-zone/iam-user"
  
  source = "github.com/alexrf45/tf-modules-resume//landing-zone/iam-user?ref=v2.1.0"
  
  for_each = toset(var.user_names)
  user_name = each.value
}
