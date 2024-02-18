# Postgre SQL Server COnfiguration

resource "azurerm_postgresql_server" "postgre" {
  name                = var.postgre_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name            = "GP_Gen5_2"
  version             = "11"
  storage_mb = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled   = false
  

  administrator_login          = "psadmin"
  administrator_login_password = "P@ssw0rd1234"
  ssl_enforcement_enabled = true

 tags = var.tags
 
  # Additional configuration options can be added as needed
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnetB
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnetB_address_prefix]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_postgresql_virtual_network_rule" "example" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = var.resource_group_name
  server_name                          = var.postgre_name
  subnet_id                            = var.subnet_id
  ignore_missing_vnet_service_endpoint = true
  depends_on = [ var.postgre_name, 
  var.resource_group_name,var.subnetB ]
}

# Postgre SQL Database Configuration

resource "azurerm_postgresql_database" "example" {
  name                = "exampledb"
  resource_group_name = var.resource_group_name
  server_name         = var.postgre_name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on = [ var.postgre_name,var.resource_group_name,
  azurerm_postgresql_virtual_network_rule.example,
  azurerm_subnet.internal ]
 
}

