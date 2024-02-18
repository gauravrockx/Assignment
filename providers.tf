terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.10.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "cb23ce95-c06b-438d-9ecc-dfa9f5765d07"
  tenant_id       = "98053b55-fa1e-4ce4-a468-32d616d84884"
  client_id       = "9d6a6e6b-dcf4-4690-945b-2db871126e65"
  client_secret   = "Tn38Q~Paem1jW5TA3dw87D_Jg16GndMANCfwgaDq"
  features {}
}
  