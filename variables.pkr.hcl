variable "aws_profile" {
  type    = string
  default = "kobokan-aer"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "region" {
  type    = string
  default = "ap-southeast-3"
}

variable "ssh_key" {
  type    = string
  default = "/path/to/ssh-key"
}
