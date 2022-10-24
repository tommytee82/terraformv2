resource "azurerm_virtual_network" "test" {
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  location            = var.location
  name                = var.vnetname
  resource_group_name  = var.rgname
}

resource "azurerm_subnet" "test" {
  name                 = var.subname
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = var.address_prefixes
}