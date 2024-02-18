/*
output "azurerm_resource_group" {
    value = azurerm_resource_group.vmss-rg.name
}
*/

output "location" {
    value = azurerm_public_ip.loadpubip.location
}

output "scaleset" {
  value = azurerm_linux_virtual_machine_scale_set.scaleset
}