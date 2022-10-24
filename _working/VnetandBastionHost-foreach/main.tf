# https://www.youtube.com/watch?v=RsDgtUZAugA&list=PLnWpsLZNgHzVVslxs8Bwq19Ng0ff4XlFv&index=6

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.27.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vnet_rg" {
  location = var.location
  name     = var.resourcegroup_name
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = var.vnet_address_space
  location            = var.location
  name                = var.vnet_name
  resource_group_name = var.resourcegroup_name
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.value["name"]
  address_prefixes     = each.value["address_prefixes"]
}

#PIP is optional
resource "azurerm_public_ip" "bastion_pubip" {
  name                = "${var.bastionhost_name}PubIP"
  allocation_method   = "Static"
  location            = var.location
  resource_group_name = var.resourcegroup_name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastionhost_name
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  tags = var.tags

    ip_configuration {
      name                 = "bastion_config"
      public_ip_address_id = azurerm_public_ip.bastion_pubip.id
      subnet_id            = azurerm_subnet.subnet["bastion_subnet"].id
    }
}














