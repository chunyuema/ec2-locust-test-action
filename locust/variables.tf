variable "region" {
  default     = "us-east-1"
  description = "Default AWS region."
}

variable "name" {
  default     = "wolf_load_testing"
  description = "Name to be used with components."
}

variable "auto_terminate_instance" {
  default     = true
  description = "Pass true enabling terminate instance after benchmarking."
}

variable "ami" {
  default     = null
  description = "AMI to use for the instance"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The instance type to use for the instance."
}

variable "key_name" {
  default     = null
  description = "Key name of the Key Pair to use for the instance"
}

variable "volume_type" {
  default     = "gp2"
  description = "Type of volume."
}

variable "volume_size" {
  default     = "50"
  description = "Size of the volume in gibibytes (GiB)."
}

variable "wait_for_fulfillment" {
  default     = true
  description = "If set, Terraform will wait for the Spot Request to be fulfilled, and will throw an error if the timeout of 10m is reached."
}

variable "spot_type" {
  default     = "one-time"
  description = "If set to one-time, after the instance is terminated, the spot request will be closed."
}

variable "slack_webhook_url" {
  type        = string
  default     = "https://hooks.slack.com/services/SomeSecretValue/SomeSecretValue/SomeSecretValue"
  description = "To dispatch messages to Slack with the webhook URL."
}

variable "github_actor" {
  default     = "Someone"
  description = "The login of the user that initiated the workflow run."
}

variable "enabled_searchers_compare" {
  default     = false
  description = "Enable searchers compare test or not."
}

variable "host_endpoint" {
  default     = "https://dummyurl.wolf.jina.ai"
  description = "Default URL For Performing Load Testing"
}

variable "slack_app_token" {
  default     = "slack app token"
  description = "Default Slack App Token"
}

variable "slack_channel" {
  default     = "slack channel"
  description = "Default Slack Channel"
}
