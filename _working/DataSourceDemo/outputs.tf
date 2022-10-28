output "vm_id" {
  value       = module.vm.vm_id_out
  description = "The ID of the new VM"
}

output "vm_ip" {
  value       = module.vm.vm_ip_out
  description = "The private IP Address for the new VM"
}

output "vnet_name" {
  value = data.azurerm_subnet.test.virtual_network_name
}
output "subnet_name" {
  value = data.azurerm_subnet.test.name
}
