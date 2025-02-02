# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

#Backend config

# terraform{
#   backend "s3" {
#     name = ""
#     bucket = "mybucket"
#     key    = "path/to/my/key"
#     region = "region"
#   }
  
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id  = var.subscription_id
}