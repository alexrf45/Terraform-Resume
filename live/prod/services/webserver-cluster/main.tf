provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Owner = "team-foo"
      ManagedBy = "Terraform"
    }
  }
}

module "webserver_cluster" {
  source = "github.com/alexrf45/tf-modules-resume//services/webserver-cluster?ref=v2.4.0"
  
  cluster_name            = "webserver-prod"
  db_remote_state_bucket  = "tf-state-resume-prod"
  db_remote_state_key     = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 10

  custom_tags = {
    Owner = "team-foo"
    ManagedBy = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

