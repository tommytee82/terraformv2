

resource "azurerm_resource_group" "example" {
  name     = "${var.rg_name}-rg"
  location = "${var.location}"
}

