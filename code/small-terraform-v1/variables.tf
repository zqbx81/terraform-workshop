variable "region" {
  type = string
}

variable "profile" {
  type        = string
  default     = ""
  description = "AWS profile name as set in the shared credentials file"
}

variable "vpc_name" {}

variable "sg_name" {}

variable "allowed_account_ids" {
  type    = list(any)
  default = []
}
