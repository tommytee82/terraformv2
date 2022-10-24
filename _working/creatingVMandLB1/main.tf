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
  skip_provider_registration = true
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
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4"]
}


resource "azurerm_subnet" "test" {
  name                 = "testsubnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_public_ip" "test" {
  name                = "publicipforLB"
  resource_group_name = azurerm_resource_group.test.name
  allocation_method   = "Static"
  location            = azurerm_resource_group.test.location
  domain_name_label   = azurerm_resource_group.test.name
  sku                 = "Standard"
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
}

resource "azurerm_network_security_group" "test" {
  location            = azurerm_virtual_network.test.location
  name                = "nsg01"
  resource_group_name = var.resource_group_name
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "allow_tf_test_taint"
    priority                   = 101
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.160.4.0/32"
    destination_address_prefix = "10.160.4.0/32"
  }
}

//VM
resource "azurerm_virtual_machine" "MyVM" {
  name                  = "vm01"
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
}

#Manages the association between a Network Interface and a Network Security Group.
/*resource "azurerm_network_interface_security_group_association" "test" {
  network_interface_id      = azurerm_network_interface.test.id
  network_security_group_id = azurerm_network_security_group.test.id
}*/

#Manages the association between a subnet and a Network Security Group.
resource "azurerm_subnet_network_security_group_association" "test" {
  network_security_group_id = azurerm_network_security_group.test.id
  subnet_id                 = azurerm_subnet.test.id
}



































