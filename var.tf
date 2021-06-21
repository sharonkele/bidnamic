variable "region" {
    default = "eu-west-1"
}




data "terraform_remote_state" "services" {
    backend = "s3"
    config = {
        bucket = local.tf_state_bucket
        key =
        region =
        dynamodb_table = "terraformLock"
    }
}







locals {
    tags = {
        Environment = var.Environment
        Application_Owner = var.Application_Owner
        Application_Name = var.Application_Name
    }
}