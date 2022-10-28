variable "base_name" {
  type = string
  description = "vnet name"
}

variable "subnet_name" {
  type = string
  description = "subnet name"
}

variable "rg_name" {
  type = string
  description = "The base of the name for the RG and Storage Account"
}

variable "location" {
  type = string
  description = "location of deployment"
}

