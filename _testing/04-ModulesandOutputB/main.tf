## Two Modules, one for RG and one for SA.
## Rand used

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.27.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

module "ResourceGroup" {
    source    = "./ResourceGroup"
    rg_name = "thornterraw"
    location  = "uk south"
}

module "Network" {
    source        = "./Network"
    base_name     = "thornvnet"
    rg_name       = module.ResourceGroup.rg_name_out
    location      = module.ResourceGroup.location_out
    subnet_name   = "thornsubnet"
}


module "StorageAccount" {
    stgact_name   = "thornterra123"
    source        = "./StorageAccount"
    rg_name       = module.ResourceGroup.rg_name_out
    location      = module.ResourceGroup.location_out
    account_replication_type = "ZRS"
    account_tier             = "Standard"
}