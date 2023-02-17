provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Owner     = "team-foo"
      ManagedBy = "Terraform"
    }
  }
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name           = "webserver-prod"
  db_remote_state_bucket = "tf-state-resume-prod"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}
