resource "azurerm_kubernetes_cluster" "this" {
  name                = azurerm_resource_group.this.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  kubernetes_version        = "1.28.3"
  dns_prefix                = azurerm_resource_group.this.name
  sku_tier                  = "Free"
  workload_identity_enabled = true
  oidc_issuer_enabled       = true


  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = "temp"
    vm_size                     = "Standard_D2a_v4" # cheapest VM with a local temp disk of at least 30GB, with a sweet bonus of accelerated networking
    node_count                  = 2 # two nodes are required for meet CPU limits
    os_sku                      = "AzureLinux" # faster to deploy than Ubuntu
    os_disk_type                = "Ephemeral" # use the VM's local temp disk, faster to deploy than a networked managed disk
    os_disk_size_gb             = 30 # minimum size for AKS
    vnet_subnet_id              = azurerm_subnet.aks_nodes.id

    upgrade_settings {
      max_surge = "1"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "172.16.0.0/16" # default is 10.0.0.0/16 which overlaps with the VNet being used
    dns_service_ip = "172.16.0.10"
  }

  ingress_application_gateway {
    subnet_id = azurerm_subnet.app_gateway.id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true # enable the Secrets Store CSI Driver for Azure Key Vaults
    secret_rotation_interval = "1m"
  }
}
