variable "aws_region" {
  type = string
}

variable "availability_zone" {
  type = string
}

# Terraform backend
variable "tf_state_bucket" {
  type = string
}

variable "tf_state_key" {
  type = string
}

variable "tf_lock_table" {
  type = string
}

# Network
variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

# EC2
variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "allowed_ssh_cidr" {
  type = string
}

# Ubuntu AMI
variable "ubuntu_ami_owner" {
  type = string
}

variable "ubuntu_ami_name" {
  type = string
}

# Tags
variable "common_tags" {
  type = map(string)
}
