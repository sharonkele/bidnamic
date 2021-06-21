terraform {
    backend "s3" {
        bucket = "state-bucket"
        key = flaskapp/tf-state
        region = var.region
        dynamodb_table = "terraformLock"


    }
}