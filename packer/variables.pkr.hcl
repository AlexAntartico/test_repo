variable "region" {
  description = "Region in which to launch the AMI baking instances"
  type        = string
  default     = "us-east-1"
}

variable "instance_size" {
  description = "Size of the Producer/Relay Nodes AMI Instance to provision"
  type        = string
}

variable "source_ami_id" {
  description = "AMI ID to use as a source image"
  type        = string
  default     = "ami-0cdb8266fcd5d3d63"
}

variable "server_key_name" {
  description = "SSH Key Name to use for baking the AMI"
  type        = string
}

variable "volume_size" {
  description = "Size of the EBS Volume to use for Producer/Relay Nodes"
  type        = string
}

variable "volume_type" {
  description = "EBS Volume Type to use for the Producer/Relay Nodes. gp2 or io1"
  type        = string
}

variable "volume_mount_path" {
  description = "Name/path of the volume that is attached to the AMI for the Producer/Relay Nodes"
  type        = string
}
