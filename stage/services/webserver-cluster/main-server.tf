data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "tf-state-resume"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_launch_configuration" "example" {
  image_id = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  user_data = templatefile("user-data.sh", {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  })
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "example" {
	launch_configuration = aws_launch_configuration.example.name
	vpc_zone_identifier  = data.aws_subnets.default.ids
	target_group_arns    = [aws_lb_target_group.asg.arn]
	health_check_type    = "ELB"
	min_size = 2
	max_size = 10
	tag {
		key = "Name"
		value = "terraform-asg-example"
		propagate_at_launch = true
	}
}


