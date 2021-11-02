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
  access_key = "AKIAXPQBNOQSIJTZV7WS"
  secret_key = "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"
}