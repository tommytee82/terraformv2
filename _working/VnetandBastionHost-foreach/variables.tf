variable "resourcegroup_name" {
  type        = string
  description = "name of rg"
  default     = "thornterraformv1-rg"
}

variable "location" {
  type        = string
  description = "location of deployment"
  default     = "UK South"
}

variable "tags" {
  type        = map(string)
  description = "tags for deployment"
  default = {
    "Environment" = "Lab"
    "Owner"       = "Thomas Horn"
  }
}

variable "vnet_name" {
  type        = string
  description = "vnet name"
  default     = "VnetTFTest"
}

variable "vnet_address_space" {
  type        = list(any)
  description = "the address space of the vnet"
  default     = ["10.13.0.0/16"]
}

variable "subnets" {
  type = map(any)
  default = {
    "subnet_1" = {
      name             = "subnet_1"
      address_prefixes = ["10.13.1.0/24"]
    }
    "subnet_2" = {
      name             = "subnet_2"
      address_prefixes = ["10.13.2.0/24"]
    }
    "subnet_3" = {
      name             = "subnet_3"
      address_prefixes = ["10.13.3.0/24"]
    }
    #Name of AzureBastionSubnet
    bastion_subnet = {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.13.250.0/24"]
    }
  }
}

variable "bastionhost_name" {
  type        = string
  description = "the name of the bastion host"
  default     = "BastionHost"
}
















