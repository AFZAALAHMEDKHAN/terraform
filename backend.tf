terraform {
  backend "s3" {
    bucket = "terraform-afzaal"
    key    = "state-file/backend"
    region = "us-east-1"
  }
}