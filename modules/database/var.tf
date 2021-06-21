variable "allocated_storage" {
  
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "engine" {
    default = "mysql"
  
}
variable "engine_version" {
  default = "5.7"
}

variable "name" {
  
}

variable "username" {
  
}

variable "password" {
  
}

variable "parameter_group_name" {

}

variable "skip_final_snapshot" {
    type = bool
    default = false
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