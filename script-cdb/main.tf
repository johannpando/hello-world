terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = "~>1.44"
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "wld_rg" {
  name = var.resource_group
}

locals {
  location = var.location == null ? data.azurerm_resource_group.wld_rg.location : var.location
}

resource "azurerm_cosmosdb_account" "main" {
  name                = var.name
  location            = local.location
  resource_group_name = data.azurerm_resource_group.wld_rg.name
  offer_type          = var.offer_type
  kind                = "MongoDB"

  capabilities {
      name = var.capabilities
  }
  ip_range_filter                   = var.ip_range_filter
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  enable_automatic_failover         = var.enable_automatic_failover
  enable_multiple_write_locations   = var.enable_multiple_write_locations

  consistency_policy {
    consistency_level = "Strong"
  }

  # main location
  geo_location {
    location          = local.location
    failover_priority = 0
  }

  # failover locations
  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value
      failover_priority = geo_location.key + 1
    }
  }

  tags = {
    #cost_center     = data.azurerm_resource_group.wld_rg.tags["cost_center"]
    #10product         = data.azurerm_resource_group.wld_rg.tags["product"]
    channel         = var.channel
    description     = var.description
    tracking_code   = var.tracking_code
    cia             = var.cia
  }
  depends_on = [data.azurerm_resource_group.wld_rg]
}

resource "azurerm_monitor_diagnostic_setting" "oms" {
  name                       = var.analytics_diagnostic_monitor
  target_resource_id         = azurerm_cosmosdb_account.main.id
  log_analytics_workspace_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${var.lwk_resource_group_name}/providers/microsoft.operationalinsights/workspaces/${var.lwk_name}" 

  log {
    category = "DataPlaneRequests"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "QueryRuntimeStatistics"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "MongoRequests"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "Requests"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  depends_on = [azurerm_cosmosdb_account.main]
}
