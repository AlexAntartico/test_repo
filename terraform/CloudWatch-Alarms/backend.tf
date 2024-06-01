# With this block we will determine how the state file for this stack of resources will be saved as.
# We are saving the state file in several files to keep things organized.
terraform {
  backend "s3" {
    key     = "cw-alarms.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}