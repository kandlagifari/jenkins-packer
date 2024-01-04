variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "Jenkins Master"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t3.small"
}

variable "aws_profile" {
  type        = string
  description = "Custom AWS Profile"
  default     = "default"
}

variable "allowed_ip" {
  type        = list(string)
  description = "List of Allow IP Address to Access EC2"
  default     = ["0.0.0.0/0"]
}
