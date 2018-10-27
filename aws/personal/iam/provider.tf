provider "aws" {
  region                  = "us-east-1"

}
terraform {
  backend "s3" {
    bucket = "terraform-remote-state-us-west-1"
    key    = "iam"
    region = "us-west-1"
  }
}
