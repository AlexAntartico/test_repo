variable "ami_id" {
  type = string
  # default = "ami-0cdb8266fcd5d3d63" # CENTOS 8 AMI
  default = "ami-084272c54c560ab80" # Golden AMI v5 Creative & Script Fixes
}

variable "instance_size" {
  type    = string
  default = "c5a.xlarge"
}

variable "server_key" {
  type    = string
  default = "minecraft-server-key"
}

variable "remote_state_bucket" {
  type        = string
  description = "Remote State Bucket to fetch outputs from other stacks"
}

variable "server_domain_name" {
  type        = string
  description = "The main domain from which our subdomain will be created from"
}

variable "server_subdomain_name" {
  type        = string
  description = "The sub domain name the server will use to be presented in the end to the player so he can connect"
}
