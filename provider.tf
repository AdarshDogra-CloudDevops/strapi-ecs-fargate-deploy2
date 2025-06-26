terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "strapi-ecs-tf-state-bucket"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "strapi-ecs-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

