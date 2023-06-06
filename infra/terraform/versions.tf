terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = ">= 2.20.0"
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.60.0"
    }
  }
}