terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "azurerm" {
  features {}
}


locals {
  tags = {
    environment = "lab"
    owner = "Tom"
  }

  account_tier = {
    account_tier_size = "Standard"
  }
}

resource "azurerm_resource_group" "resourcegroup" {
  name      = var.rsgname
  location  = var.location
  tags      = local.tags
}

resource "azurerm_storage_account" "example" {
  name                     = var.stgactname
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = local.account_tier.account_tier_size
  account_replication_type = "GRS"

  tags = local.tags
}
#a comment