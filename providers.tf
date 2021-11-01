#####/root/providers.tf#####

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA26KI47A2FZMF247S"
  secret_key = "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"
}