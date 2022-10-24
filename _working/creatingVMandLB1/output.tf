output "resource_group_name" {
  value = azurerm_resource_group.test.name
}
output "vnet_address_space" {
  value = azurerm_virtual_network.test.address_space[0]
}

output "subnet_prefixes" {
  value = azurerm_subnet.test.address_prefixes[0]
}

output "public_ip_address" {
  value = azurerm_public_ip.test.ip_address
}

output "location" {
  value = azurerm_resource_group.test.location
}

output "load_balancer_name" {
  value = azurerm_lb.test.name
}
