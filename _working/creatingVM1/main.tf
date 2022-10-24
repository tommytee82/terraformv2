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
    resource_group {
      prevent_deletion_if_contains_resources = false
      }
  }
}
#for imports
#resource "azurerm_resource_group" "test" {}

#the name is referenced in the variables file
resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = "ukwest"

}

resource "azurerm_virtual_network" "test" {
  name                = "testvnet"
  location            = "ukwest"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4"]
}


resource "azurerm_subnet" "test" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "secondsubnet" {
  name                 = var.subnet_2ndname
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

  resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.secondsubnet.id
  network_security_group_id = azurerm_network_security_group.example.id
    depends_on = [azurerm_subnet.secondsubnet]
    
}

resource "azurerm_network_interface" "test" {
  name                = "nic01"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_virtual_network.test.location


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip_address} > private_ips.txt"
  }
}

resource "azurerm_virtual_machine" "MyResource" {
  name                  = "vm02"
  resource_group_name   = azurerm_resource_group.test.name
  location              = "ukwest"
  network_interface_ids = [azurerm_network_interface.test.id]
  vm_size               = "Standard_B1s"




  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "14.04.2-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "${azurerm_resource_group.test.name}-os"
    # vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  storage_data_disk {
    name = "${azurerm_resource_group.test.name}-data"
    # vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/datadisk0.vhd"
    disk_size_gb  = "1023"
    create_option = "empty"
    lun           = 0
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  provisioner "local-exec" {
    command     = "Get-Date > date.txt"
    interpreter = ["PowerShell", "-Command"]
  }
  provisioner "local-exec" {
    command = "echo ${self.vm_size} > vm_size.txt"
  }
}









