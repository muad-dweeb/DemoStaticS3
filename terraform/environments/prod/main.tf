terraform {
  backend "s3" {
    bucket = "akg-galloway-terraform-state"
    region = "us-east-2"
    key    = "utinni"
  }
  required_version = "1.10.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "main" {
  source = "../../modules"
}
