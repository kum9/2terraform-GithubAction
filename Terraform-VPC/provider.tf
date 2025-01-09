terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.10.0"
    }
  }
  backend "s3" {
    bucket = "terraform-remote-backend-s3-save00"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  # Configuration options
  region = "u-east-1"
}



