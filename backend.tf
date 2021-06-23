terraform {
    backend "s3" {
        bucket = "flaskapp-state-bucket"
        key = "tf-state"
        region = "eu-west-1"
        dynamodb_table = "terraformLock"


    }
}