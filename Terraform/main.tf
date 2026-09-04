terraform {
  required_version = ">=1.10"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=5.0"

    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.AzureRG
  location = var.location
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.ASAPname
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "B2"

}

resource "azurerm_windows_web_app" "webapp" {
  name                = var.webapp
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

 site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v10.0"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
