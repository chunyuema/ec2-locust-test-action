variable "slack_webhook_url" {
  type        = string
  default     = "https://hooks.slack.com/services/SomeSecretValue/SomeSecretValue/SomeSecretValue"
  description = "To dispatch messages to Slack with the webhook URL."
}
