terraform {
  backend "s3" {
    bucket = "nexgensis-devops"
    key    = "nexgensis/devops/assessment/terraform.tfstate"
    region = "us-east-1"
  }
}
