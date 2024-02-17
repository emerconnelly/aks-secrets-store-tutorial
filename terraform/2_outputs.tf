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
