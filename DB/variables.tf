variable "resource_group_name" {
  type = string
  description = "This defines the Resource group for PostgreDB"
}

variable "location" {
  type = string
  description = "This defines the Location details for PostgreDB"
}


variable "postgre_name" {
  type = string
  description = "This defines the PostgreDB Name"
}


variable "virtual_network_name" {
  type = string
  description = "This defines the virtual network details"
}

variable "virtual_network_address_space" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "subnetB" {
  type = string
}

variable "subnetB_address_prefix" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    environment = "testlab"
  }
}