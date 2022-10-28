## Two Modules, one for RG and one for SA.
## Rand used
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.27.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "thorn-terraformstate-rg"
    storage_account_name = "thornterraformstate90210"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "Ez3cTU0VcDs2bbML03sxMr/z3z10U15z8mYZXsU1OCzuhqeplR4Uk05kWdABqUc8/IROlQXjJNHR+AStfOOS+g=="
  }
}

provider "azurerm" {
  features {
  }
}

module "ResourceGroup" {
    source    = "./Modules/ResourceGroup"
    rg_name = "thornterraformv1"
    location  = "uk south"
}

module "Network" {
    source        = "./Modules/Network"
    base_name     = "thornterra"
    rg_name       = module.ResourceGroup.rg_name_out
    location      = module.ResourceGroup.location_out
    subnet_name   = "thornterra01"
}

module "StorageAccount" {
    stgact_name   = "thornterratest"
    source        = "./Modules/StorageAccount"
    rg_name       = module.ResourceGroup.rg_name_out
    location      = module.ResourceGroup.location_out
    account_replication_type = "ZRS"
    account_tier             = "Standard"
}