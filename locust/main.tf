provider "aws" {
  region = "us-east-1"
}

variable "slack_webhook_url" {
  type        = string
  default     = "https://hooks.slack.com/services/SomeSecretValue/SomeSecretValue/SomeSecretValue"
  description = "To dispatch messages to Slack with the webhook URL."
}

data "template_file" "userdata" {
  template = file("./locust_test.sh")
  vars = {
    slack_webhook_url = var.slack_webhook_url
  }
}

resource "aws_instance" "wolf_load_test_server_dev" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags          = { Name = "Wolf Load Test Dev" }
  user_data     = data.template_file.userdata.rendered
}
