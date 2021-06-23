variable "region" {
    default = "eu-west-1"
}

variable "cidr_block_range" {
    default = ["0.0.0.0/0"]
}

variable "repository_name" {
    type = string
    default = "bidnamic"
}

variable "repository_branch" {
    type = string
    default = "s3-static"
}


variable "artifacts_bucket_name" {
    type = string
    default = "flaskapp-static-s3"
}

variable "bucket" {
    type = string
    description = "name of static website bucket"
    default = "flaskapp"
}