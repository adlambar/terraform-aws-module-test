terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
   region  = var.region
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}