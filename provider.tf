# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_regions_variable
  profile = "default"
}


# Provider-2 for us-east-2 (ohio)
provider "aws" {
  region  = "us-east-2"
  alias   = "ohio"
  profile = "default"
}