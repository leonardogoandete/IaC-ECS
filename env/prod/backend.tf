terraform {
  backend "s3" {
    bucket  =   "terraform-state-alura"
    key     =   "prod/terraform.tfstate"
    region  =   "us-west-2"
  }
}