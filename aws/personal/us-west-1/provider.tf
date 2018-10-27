provider "aws" {
  region                  = "us-west-1"

}
terraform {
  backend "s3" {
    bucket = "terraform-remote-state-us-west-1"
    key    = "us-west-1"
    region = "us-west-1"
  }
}
