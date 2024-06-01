variable "remote_state_bucket" {
  type        = string
  description = "Remote State Bucket to fetch outputs from other stacks"
}

variable "sms_numbers" {
  type = list(string)
}