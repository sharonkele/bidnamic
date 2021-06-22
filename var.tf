variable "region" {
    default = "eu-west-1"
}

variable "allocated_storage" {
  default = 5
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
    type = string
    default = "flask-app-database"
  
}

variable "username" {
  type = string
  default = ""
}

variable "password" {
    type = string
    default = ""
  
}

variable "parameter_group_name" {
    type = string
    default = ""

}

variable "skip_final_snapshot" {
    type = bool
    default = false
}

variable "instance_ami" {
    type = string
    default = "ami-0ac43988dfd31ab9a"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}


variable "cidr_block_range" {
    default = ["0.0.0.0/0"]
}