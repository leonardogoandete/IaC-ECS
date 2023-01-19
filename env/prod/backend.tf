terraform {
  backend "s3" {
    bucket  =   "terraform-state-alura-v1"
    key     =   "prod/terraform.tfstate"
    region  =   "us-west-2"
  }
}