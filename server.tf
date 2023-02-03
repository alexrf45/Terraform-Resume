data "aws_vpc" "default" {
	default = true
}

data "aws_subnets" "default" {
	filter {
		name 	 = "vpc-id"
		values = [data.aws_vpc.default.id]
	}
}


resource "aws_launch_configuration" "example" {
  image_id = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  user_data = <<-EOF
							#!/bin/bash
							echo "Hello, World" > index.html
							nohup busybox httpd -f -p ${var.server_port} &
							EOF
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


