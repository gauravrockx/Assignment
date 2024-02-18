output "azurerm_resource_group" {
    value = azurerm_resource_group.testrg.name
}

output "location" {
    value = azurerm_virtual_network.testnetwork.location
}

output "azurerm_virtual_network" {
   value = azurerm_virtual_network.testnetwork.name
}

output "virtual_network_address_space" {
   value = azurerm_virtual_network.testnetwork.address_space
}


output "subnetid" {
    value = azurerm_subnet.subnetA.id
}

output "subnetA" {
    value = azurerm_subnet.subnetA
}

output "subnetB" {
    value = azurerm_subnet.subnetB
}

output "resource_group_name" {
    value = azurerm_resource_group.testrg
}

output "subnetBid" {
    value = azurerm_subnet.subnetB.id
}

output "subnetB_address_prefix" {
  value = azurerm_subnet.subnetB
}