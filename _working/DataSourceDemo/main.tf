# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    virtual_machine {
      skip_shutdown_and_force_delete = true
      delete_os_disk_on_deletion     = true
    }
  }
}

resource "azurerm_resource_group" "test" {
  name     = "thorntestdatasource"

}

data "azurerm_subnet" "test" {
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  name                 = var.subname

}


module "vm" {
  source     = "./WinServer"
  rgname     = azurerm_resource_group.test.name
  location   = azurerm_resource_group.test.location
  subnetid   = data.azurerm_subnet.test.id
  vmname     = "thornvm"
  size       = "Standard_B2s"
  localadmin = "localadmin"
  adminpw    = var.adminpw
}


module "Network" {
  source           = "./Network"
  rgname           = var.rgname
  location         = var.location
  vnetname         = var.vnetname
  subname          = var.subname
  address_space    = ["10.0.0.0/16"]
  dns_servers      = ["10.0.0.4"]
  address_prefixes = ["10.0.1.0/24"]
}
