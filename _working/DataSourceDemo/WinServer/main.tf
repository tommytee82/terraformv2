
resource "azurerm_network_interface" "netinterface" {
  name                = "${var.vmname}-nic"
  resource_group_name = var.rgname
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vmname
  resource_group_name   = var.rgname
  location              = var.location
  vm_size               = var.size
  network_interface_ids = [
    azurerm_network_interface.netinterface.id,
  ]

  storage_os_disk {
    name = "storage_disk"
    create_option = "FromImage"
    caching = "ReadWrite"
  }

  os_profile_windows_config {}


  os_profile {
    computer_name  = var.vmname
    admin_username = var.localadmin
    admin_password = var.adminpw
  }

  storage_image_reference {
   publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2019-Datacenter"
    version = "latest"
  }
}









