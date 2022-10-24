terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}
/*
#creates a random string
resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

*/
resource "azurerm_storage_account" "example" {
  #name                    = "${lower(var.stgact_name)}${random_string.random.result}stvm"
  name                     = "${lower(var.stgact_name)}stvm"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}