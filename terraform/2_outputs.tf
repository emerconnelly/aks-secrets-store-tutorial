output "kubeconfig" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Kubeconfig for AKS cluster"
  sensitive   = true
}

output "sql_connection_string" {
  value       = local.sql_connection_string
  description = "Connection string for the Azure SQL Database created."
  sensitive   = true
}

output "aks_app_gateway_ingress_public_ip" {
  value       = data.azurerm_public_ip.this.ip_address
  description = "Public IP of the AKS Application Gateway Ingress"
}

# replace value in secrets-provider-class.yaml
output "aks_identity_tenant_id" {
  value       = azurerm_kubernetes_cluster.this.identity[0].tenant_id
  description = "Tenant ID of the Azure AD identity created for the AKS cluster."
}

# replace value in secrets-provider-class.yaml
output "key_vault_name" {
  value       = azurerm_key_vault.this.name
  description = "Name of the Azure Key Vault created."
}

# replace value in secrets-provider-class.yaml
output "aks_key_vault_identity_client_id" {
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
  description = "Client ID of the Azure AD identity created for the AKS cluster."
}
