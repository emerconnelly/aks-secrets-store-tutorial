resource "azurerm_mssql_server" "this" {
  name                = substr("${azurerm_resource_group.this.name}-${random_id.this.dec}", 0, 64) # create a unique name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11" # do not use plain-text password in git in prod
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_virtual_network_rule" "this" {
  name = "this"

  server_id = azurerm_mssql_server.this.id
  subnet_id = azurerm_subnet.aks_nodes.id
}

resource "azurerm_mssql_database" "this" {
  name = azurerm_resource_group.this.name

  server_id                   = azurerm_mssql_server.this.id
  sku_name                    = "GP_S_Gen5_1"
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  storage_account_type        = "Local"
  max_size_gb                 = 5
  min_capacity                = 0.5
  auto_pause_delay_in_minutes = 60
}
