resource "azurerm_resource_group" "testrg" {
  name     = var.resource_group_name
  location = var.location
  tags = var.tags
}

# Virtual Network Configuration with two Subnets

resource "azurerm_virtual_network" "testnetwork" {
  name                = var.virtual_network_name
  address_space       = [var.virtual_network_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [ azurerm_resource_group.testrg]

  tags = var.tags
  
}

# SubnetA will be used by VMSS for virtual machines

resource "azurerm_subnet" "subnetA" {
  name                 = var.subnetA
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnetA_address_prefix]
 depends_on = [ azurerm_virtual_network.testnetwork,
 azurerm_resource_group.testrg]
}

# SubnetB will be used by Postgre SQL Server for database

resource "azurerm_subnet" "subnetB" {
  name                 = var.subnetB
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnetB_address_prefix]
 depends_on = [ azurerm_virtual_network.testnetwork,
 azurerm_resource_group.testrg ]
}

/*
resource "azurerm_network_security_group" "test-nsg" {
  name                = "test-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [ azurerm_resource_group.var.resource_group_name ]

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "test-nsgast" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.test-nsg.id
  depends_on = [ azurerm_network_security_group.test-nsg,
  azurerm_subnet.subnetA ]
}
*/