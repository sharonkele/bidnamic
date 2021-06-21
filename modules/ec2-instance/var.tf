variable "instance_ami" {
    type = string
    default = 
}

variable "instance_type" {
    type = string
    default = 
}


variable "Environment" {}

variable "Application_Owner" {}

variable "Application_Name" {}


locals {
    tags = {
        Environment = var.Environment
        Application_Owner = var.Application_Owner
        Application_Name = var.Application_Name
    }
}