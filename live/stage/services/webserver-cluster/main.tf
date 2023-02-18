provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner     = "Sean Fontaine"
      ManagedBy = "Terraform"
    }
  }
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  ami         = "ami-0dfcb1ef8550277af"
  server_text = "New Server Text"

  cluster_name           = "webserver-stage"
  db_remote_state_bucket = "tf-state-resume-stage"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}


