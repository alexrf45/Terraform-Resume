provider "aws" {
  region = "us-east-2"
}

#terraform {
#  backend "s3" {
#    bucket = "tf-state-resume-prod"
#    key = "prod/data-stores/mysql/terraform.tfstate"
#    region = "us-east-2"
#    dynamodb_table = "terraform-up-and-running-locks"
#  }
#}
