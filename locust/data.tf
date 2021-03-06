locals {
  timestamp = timestamp()
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  default_for_az    = true
  availability_zone = "us-east-1a"
}

data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "userdata" {
  template = file("./locust_test.sh")
  vars = {
    slack_webhook_url = "${var.slack_webhook_url}"
    host_endpoint     = "${var.host_endpoint}"
    slack_app_token   = "${var.slack_app_token}"
    slack_channel     = "${var.slack_channel}"
  }
}
