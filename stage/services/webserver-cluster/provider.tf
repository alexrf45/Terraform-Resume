terraform {
  backend "s3" {
    bucket = "tf-state-resume"
    region = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    key = "stage/services/webserver-cluster/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
	region = "us-east-2"
}
