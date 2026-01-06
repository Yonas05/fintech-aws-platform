terraform {
  required_version = ">=1.5.0"
  required_providers {
    
    aws={
        source = "hashicorp/aws"
        version = "~>5.50"
    }
  }
  backend "s3" {
    bucket         = "tfstate-example-bucket"
    key            = "fintech-aws-platform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-locks"
    encrypt        = true
  }
}
provider "aws" {
    region = var.aws_region
  }