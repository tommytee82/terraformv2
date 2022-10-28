variable "stgact_name" {
  type = string
  description = "The base of the name for the Storage Account"
}

variable "location" {
  type = string
  description = "location of deployment"
}

variable "rg_name" {
  type = string
  description = "rg name"
}

variable "account_tier" {
  type = string
  description = "the type of sku"
}

variable "account_replication_type" {
  type = string
  description = "account replication type"
}
