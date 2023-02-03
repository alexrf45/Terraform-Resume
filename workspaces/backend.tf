provider "aws" {
  region = "us-east-2"
}


terraform {
  backend "s3" {
  # Replace this with your bucket name!
    bucket = "tf-state-resume"
    key = "workspace-example/terraform.tfstate"
    region = "us-east-2"
  # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
  }
}
