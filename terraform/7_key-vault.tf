resource "azurerm_key_vault" "this" {
  name                = substr("${replace(azurerm_resource_group.this.name, "-", "")}${random_id.this.dec}", 0, 24) # create a unique name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  tenant_id                  = data.azurerm_client_config.this.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  enable_rbac_authorization  = true
}

resource "azurerm_key_vault_secret" "sql_connection_string" {
  name = "sql-connection-string"

  key_vault_id = azurerm_key_vault.this.id
  value        = local.sql_connection_string

  depends_on = [azurerm_role_assignment.tf_azurerm_identity]
}

resource "azurerm_key_vault_secret" "kubeconfig" {
  name = "kubeconfig"

  key_vault_id = azurerm_key_vault.this.id
  value        = azurerm_kubernetes_cluster.this.kube_config_raw

  depends_on = [azurerm_role_assignment.tf_azurerm_identity]
}
