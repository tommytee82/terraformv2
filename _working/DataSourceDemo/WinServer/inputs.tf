variable "rgname" {
    type = string
  description = "rg name"
}

variable "location" {
  type = string
  description = "location"
}

variable "subnetid" {
  type = string
  description = "subnet id the nic attaches"
}

variable "vmname" {
  type = string
  description = "vm name"
}

variable "size" {
  type = string
  description = "size"
}

variable "localadmin" {
  type = string
  description = "user"
}

variable "adminpw" {
  type = string
  sensitive = true
  description = "local admin pw1"
}