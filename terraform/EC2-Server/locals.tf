data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "s3-backup.tfstate"
    region = "us-east-1"
  }
}

data "aws_route53_zone" "main" {
  name = "armandoherra.games"
}

data "aws_vpc" "default" {
  default = true
}
