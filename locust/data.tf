data "template_file" "userdata" {
  template = file("./locust_test.sh")
  vars = {
    slack_webhook_url = "{$var.slack_webhook_url}"
  }
}
