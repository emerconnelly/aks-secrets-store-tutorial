resource "random_id" "this" {
  byte_length = 8 # used to create unique names for public resources
}

resource "azurerm_resource_group" "this" {
  name = "aks-secrets-store-tutorial" # all resources will use this name

  location = "eastus" # cheapest location to deploy these resources to
}
