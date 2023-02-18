provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "tf-state-resume-stage"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks"
  }
}
