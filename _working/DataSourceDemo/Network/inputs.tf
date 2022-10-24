#Subnet Vars
variable "rgname" {
  type        = string
  description = "The name of vnet RG 11"
}
variable "location" {
  description   = "location of vnet"
  #tfvars is ukwest so overrules:
  default = "uksouth"
}
variable "vnetname" {
  type        = string
  description = "The name of existing vnet"
}
variable "subname" {
  type        = string
  description = "The name of existing Subnet"
}

variable "address_space" {
  type = list(any)
  description   = "local admin pw, 12 char long or longer"
}
variable "address_prefixes" {
  type = list(any)
}
variable "dns_servers" {
  type = list(any)
}


