output "azure_subnet_id_out" {
  value = {
  for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].id
  }
  description = "lists of ID's of the subnets"
}
output "bastion_pubip" {
  value = azurerm_public_ip.bastion_pubip.ip_address
}