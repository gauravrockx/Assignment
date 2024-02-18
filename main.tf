module "networking_module" {
  source                        = "./networking"

  #Resource Group and location, VNet and Subnet details

  resource_group_name           = "test-rg"
  location                      = "West Europe"
  virtual_network_name          = "Test-network"
  virtual_network_address_space = "10.0.0.0/16"
  subnetA                       = "SubnetA"
  subnetB                       = "SubnetB"
  subnetA_address_prefix        = "10.0.1.0/24"
  subnetB_address_prefix        = "10.0.2.0/24"
}

#Virtual Machine Scale Set details

module "vmss_module" {
  source              = "./VMSS"
  resource_group_name = module.networking_module.azurerm_resource_group
  location            = "West Europe"
  scaleset_name       = "vmss-scale"
  subnet_id           = module.networking_module.subnetid
}

#Postgre SQL database details

module "postgre_module" {
  source = "./DB"
  postgre_name = "test-server007877"
  resource_group_name = module.networking_module.azurerm_resource_group
  location            = "West Europe"
  virtual_network_name = module.networking_module.azurerm_virtual_network
  subnet_id = module.networking_module.subnetBid
  virtual_network_address_space = "10.0.0.0/16"
  subnetB_address_prefix = "10.0.2.0/24"
  subnetB = "SubnetB"

}
