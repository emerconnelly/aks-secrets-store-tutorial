resource "azurerm_kubernetes_cluster_extension" "flux" {
  name       = "microsoft.flux"
  cluster_id = azurerm_kubernetes_cluster.this.id

  extension_type    = "microsoft.flux"
  release_namespace = "flux-system"
  configuration_settings = {
    "image-automation-controller.enabled"              = true,
    "image-reflector-controller.enabled"               = true,
    "notification-controller.enabled"                  = true,
  }
}

resource "azurerm_kubernetes_flux_configuration" "proget" {
  name       = azurerm_resource_group.this.name
  cluster_id = azurerm_kubernetes_cluster.this.id

  namespace                         = "flux-system"
  scope                             = "cluster"
  continuous_reconciliation_enabled = true

  git_repository {
    url                      = "https://github.com/emerconnelly/aks-secrets-store-tutorial" # replace with your GitHub repo
    reference_type           = "branch"
    reference_value          = "main"
    sync_interval_in_seconds = 60
    timeout_in_seconds       = 60
  }

  kustomizations {
    name                       = "this"
    path                       = "./k8s/"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 30
    retry_interval_in_seconds  = 30
    timeout_in_seconds         = 60
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux,
    azurerm_mssql_database.this,
  ]
}
