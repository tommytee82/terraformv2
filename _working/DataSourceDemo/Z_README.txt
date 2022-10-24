To recreate, provision a Vnet and Subnet

Import Vnet and Subnet into State, first create the resource block inside a module called Network

Import with:
 e.g:
terraform.exe import module.Network.azurerm_virtual_network.test /subscriptions/cc7b1513-5bf6-41fb-b528-fb9281164880/resourceGroups/thorntestdatasource/providers/Microsoft.Network/virtualNetworks/vnet01 