terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.31.0"
    }
  }
}


provider "aws" {
  region  = var.region
  profile = "manh-huydinh@techxcorp.com"
  shared_credentials_file  = "./Users/tmanh/.aws/credentials"
}


module "instance" {
  source = "./instance-vpc/"
}



