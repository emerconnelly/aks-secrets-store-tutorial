# grant secret creation access for the Key Vault to the Terraform AzureRM execution identity
resource "azurerm_role_assignment" "tf_azurerm_identity" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = data.azurerm_client_config.this.object_id
}

# grant read access for the Key Vault to the AKS Secrets Store CSI Driver managed identity
resource "azurerm_role_assignment" "aks_secrets_store_csi_driver_identity" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_reader.id
  principal_id       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id
}

# grant Network Administrator access to the AKS Application Gateway Ingress Controller managed identity
resource "azurerm_role_assignment" "aks_application_gateway_ingress_controller_identity" {
  scope              = azurerm_subnet.app_gateway.id
  role_definition_id = data.azurerm_role_definition.network_contributor.id
  principal_id       = azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}
