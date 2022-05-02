variable "slack_webhook_url" {
  type        = string
  default     = "https://hooks.slack.com/services/SomeSecretValue/SomeSecretValue/SomeSecretValue"
  description = "To dispatch messages to Slack with the webhook URL."
}

variable "host_endpoint" {
  type        = string
  default     = "https://dummyurl.wolf.jina.ai"
  description = "Endpoint used to perform the load testing."
}
