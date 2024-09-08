terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.10.0"
    }
  }
  backend "s3" {
    bucket = "terraform-remote-backend-s3-save"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}


provider "aws" {
  # Configuration options
  region = "ap-south-1"
}



