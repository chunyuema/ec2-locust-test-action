terraform {
  required_version = ">= 1"

  required_providers {
    aws = {
      version = ">= 3.54"
      source  = "hashicorp/aws"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
}

provider "aws" {
  region = var.region
}


provider "template" {}
