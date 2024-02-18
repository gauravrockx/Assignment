variable "resource_group_name" {
  type = string
  description = "This defines the resource group name"
}

variable "location" {
  type = string
}

variable "scaleset_name" {
  type = string
  description = "This defines the name for Virtual Machine Scale Set"
}

variable "subnet_id" {
  type = string
  description = "This defines the subnet id"
}

variable "tags" {
  type = map(string)
  default = {
    environment = "testlab"
  }
}