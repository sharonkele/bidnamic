variable "cidr_block_range" {
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