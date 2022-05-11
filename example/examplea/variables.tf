variable "region" {
  default = "us-west-1"
  type    = string
}

variable "instance_type" {
  type        = string
  description = "AWS instance type"
}
