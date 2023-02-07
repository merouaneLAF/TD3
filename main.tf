terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0, < 2.0.0"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_launch_configuration" "exemple" {
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World J-9 :)" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF


  #user_data_replace_on_change = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "exemple" {
  launch_configuration = aws_launch_configuration.exemple.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  min_size = 2
  max_size = 7

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "instance" {
  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

variable "security_group_name" {
  description = "The name of security group"
  type        = string
  default     = "terraform-exemple-instance"

}

data "aws_vpc" "default" {
    default = true
}