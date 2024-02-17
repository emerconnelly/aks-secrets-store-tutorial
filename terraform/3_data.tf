data "azurerm_subscription" "this" {}

data "azurerm_client_config" "this" {}

data "azurerm_role_definition" "key_vault_administrator" {
  name  = "Key Vault Administrator"
  scope = azurerm_key_vault.this.id
}

data "azurerm_role_definition" "key_vault_secrets_reader" {
  name  = "Key Vault Secrets Reader"
  scope = azurerm_key_vault.this.id
}

data "azurerm_role_definition" "network_contributor" {
  name  = "Network Contributor"
  scope = azurerm_subnet.app_gateway.id
}

data "azurerm_public_ip" "this" {
  name                = "applicationgateway-appgwpip"
  resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group
}
