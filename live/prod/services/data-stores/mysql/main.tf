provider "aws" {
  region = "us-east-1"
  alias  = "primary"
}

provider "aws" {
  region = "us-east-2"
  alias  = "replica"
}

terraform {
  backend "s3" {
    bucket         = "tf-state-resume-prod"
    key            = "prod/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks-prod"
  }
}

module "mysql_primary" {
  source = "../../../../../modules/data-stores/mysql"
  providers = {
    aws = aws.primary
  }

  db_name     = "prod_db"
  db_username = var.db_username
  db_password = var.db_password

  backup_retention_period = 1

}

module "mysql_replica" {
  source = "../../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }
  replicate_source_db = module.mysql_primary.arn

}
