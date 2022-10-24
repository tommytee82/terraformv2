#Subnet Vars
variable "rgname" {
  type        = string
  description = "The name of vnet RG"
}

variable "location" {
  type        = string
  description = "location"
}

variable "vnetname" {
  type        = string
  description = "The name of existing vnet"
}

variable "subname" {
  type        = string
  description = "The name of existing Subnet"
}

variable "adminpw" {
  sensitive = true
  default   = "local admin pw, 12 char long or longer"
}

