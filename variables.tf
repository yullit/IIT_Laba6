variable "aws_region" {
  description = "AWS region to create resources in"
  default     = "eu-west-2"
}

variable "instance_type" {
  description = "Type of EC2 instance to run"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "lab6"
}

variable "project_name" {
  description = "Project name"
  default     = "lab6"
}