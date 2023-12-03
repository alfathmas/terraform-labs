terraform {
  backend "s3" {
    bucket = "terraform-backend-233dcs"
    key    = "aws-vpc/terraform.tfstate"
    region = "ap-southeast-1"

    dynamodb_table = "terraform-s3-backend"
    encrypt        = true
  }
}