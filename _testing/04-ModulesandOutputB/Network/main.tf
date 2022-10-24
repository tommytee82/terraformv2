resource "azurerm_virtual_network" "example" {
  name                = var.base_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4"]

}
resource "azurerm_subnet" "example"{
  address_prefixes     = ["10.0.0.0/24"]
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.base_name
}

