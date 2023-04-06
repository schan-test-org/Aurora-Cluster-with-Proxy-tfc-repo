############################################
# version of terraform and providers
############################################
terraform {
  cloud {
    organization = "schan-test"

    workspaces {}
  }
}

############################################
# AWS Provider Configuration
############################################
provider "aws" {
  region  = var.aws_region
  # profile = var.aws_profile
  
}