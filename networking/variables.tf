variable "resource_group_name" {
  type = string
  description = "This defines the resource group name"
}

variable "location" {
  type = string
  description = "This defines the location."
}

variable "virtual_network_name" {
  type = string
  description = "This defines the virtual network name"
}

variable "virtual_network_address_space" {
  type = string
  description = "This defines the virtual network address space details"
}

variable "subnetA" {
  type = string
  description = "This defines the subnetA details"
}

variable "subnetB" {
  type = string
  description = "This defines the subnetB details"
}

variable "subnetA_address_prefix" {
  type = string
  description = "This defines the subnetA address details"
}

variable "subnetB_address_prefix" {
  type = string
  description = "This defines the subnetB address details"
}

variable "tags" {
  type = map(string)
  default = {
    environment = "testlab"
  }
}