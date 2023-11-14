variable "aws_secret_key" {
 type = string
}

variable "aws_access_key" {
 type = string
}

variable "aws_ssh_key" {
 type = string
}

variable "ami" {
    type = string
    default = "ami-06dd92ecc74fdfb36"
}

variable "instance_type" {
    type = string
    default = "t2.small"
}

locals {
  vm_settings = [
    { name = "maestro-nginx-01", location = "eu-central-1",subnet_id = aws_subnet.root_sub_a.id},
    { name = "maestro-nginx-02", location = "eu-central-1",subnet_id = aws_subnet.root_sub_b.id},
  ]
}

variable "database_pass" {
    type = string
    default = "pass32f2gh35h"
}
variable "database_user" {
    type = string
    default = "sammy"
}
variable "database_name" {
    type = string
    default = "wordpress"
}