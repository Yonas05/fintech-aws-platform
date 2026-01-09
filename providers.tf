terraform {
  required_version = ">=1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.50"
    }
  }

  backend "remote" {
    organization = "yonasf-Org"

    workspaces {
      name = "fintech-aws-platform"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
