resource "azurerm_lb" "test" {
  location            = azurerm_resource_group.test.location
  name                = "lb01"
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "publicipaddress"
    public_ip_address_id = azurerm_public_ip.test.id
  }
}
resource "azurerm_lb_backend_address_pool" "test" {
  name = "BackEndAddressPool"
  #resource_group_name = azurerm_resource_group.test.name
  loadbalancer_id = azurerm_lb.test.id

}

resource "azurerm_lb_nat_pool" "test" {
  backend_port                   = 22
  frontend_ip_configuration_name = "publicipaddress"
  frontend_port_end              = 50119
  frontend_port_start            = 50000
  loadbalancer_id                = azurerm_lb.test.id
  name                           = "ssh"
  protocol                       = "Tcp"
  resource_group_name            = azurerm_resource_group.test.name
}

resource "azurerm_lb_probe" "test" {
  loadbalancer_id = azurerm_lb.test.id
  name            = "http-probe"
  port            = 80
  request_path    = "/"
  protocol        = "Http"
}

resource "azurerm_lb_rule" "test" {
  backend_port                   = 4001
  frontend_ip_configuration_name = "publicipaddress"
  frontend_port                  = 4001
  loadbalancer_id                = azurerm_lb.test.id
  name                           = "myLbRule"
  protocol                       = "Tcp"
  disable_outbound_snat          = true
  enable_floating_ip             = true
}

resource "azurerm_lb_outbound_rule" "test" {
  backend_address_pool_id = azurerm_lb_backend_address_pool.test.id
  loadbalancer_id         = azurerm_lb.test.id
  name                    = "myObRule"
  protocol                = "Tcp"

  frontend_ip_configuration {
    name = "publicipaddress"
  }
}

resource "azurerm_lb_nat_rule" "test" {
  backend_port                   = 3389
  frontend_ip_configuration_name = "publicipaddress"
  frontend_port                  = 3389
  loadbalancer_id                = azurerm_lb.test.id
  name                           = "RDPAccess"
  protocol                       = "Tcp"
  resource_group_name            = azurerm_resource_group.test.name
}














































