terraform {
  required_version = ">= 1.7.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      # do not use these in prod
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
	}
}
