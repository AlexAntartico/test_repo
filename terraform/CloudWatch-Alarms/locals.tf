data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "ec2-server.tfstate"
    region = "us-east-1"
  }
}

locals {
  sms_numbers = tolist(var.sms_numbers)
}