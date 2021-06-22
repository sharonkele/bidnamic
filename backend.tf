terraform {
    backend "s3" {
        bucket = "state-bucket"
        key = "flaskapp/tf-state"
        region = "eu-west-1"
        dynamodb_table = "terraformLock"


    }
}