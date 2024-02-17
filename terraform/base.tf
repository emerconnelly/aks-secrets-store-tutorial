resource "random_id" "this" {
  byte_length = 8 # used to create unique names for public resources
}

resource "azurerm_resource_group" "this" {
  name = "secrets-store-tutorial"

  location = "eastus" # cheapest location to deploy these resources to
}
