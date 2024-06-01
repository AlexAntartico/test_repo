terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
  }
  required_version = "1.5.5"
}

provider "aws" {
  region = "us-east-1"
}