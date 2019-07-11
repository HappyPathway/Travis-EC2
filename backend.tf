terraform {
  backend "s3" {
    bucket = "foghorn-darnold-tfstate"
    key    = "coe-darnold"
    region = "us-east-1"
    dynamodb_table = "tf-state-locking"
    encrypt = true
  }
}