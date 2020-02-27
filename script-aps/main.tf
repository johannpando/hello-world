provider "azurerm" {
  version = "~>1.44"
}

# Set terraform required version
terraform {
  required_version = ">= 0.12"
  #backend "azure" {}
}

data "azurerm_resource_group" "rsg" {
  name = var.resource_group
}

/*
data "azurerm_key_vault" "kvt" {   
  name                = var.kvt_name   
  resource_group_name = data.azurerm_resource_group.rsg.name
}
*/

data "azurerm_client_config" "current" {}

resource "random_string" "password" {
     length  = 128   
     special = true   
     upper = true   
     min_upper = 2   
     lower = true   
     min_lower = 2   
     number = true   
     min_numeric = 2 
}

resource "azurerm_key_vault_secret" "PostgresqlKey" {   
  name         = local.admin_user   
  value        = random_string.password.result   
  key_vault_id = var.key_vault_id    
  #depends_on = [data.azurerm_key_vault.kvt]
  }

resource "azurerm_postgresql_server" "aps_server" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group
  tags = {     
    channel         = var.channel     
    #cost_center     = data.azurerm_resource_group.rsg.tags["cost_center"]     
    #product         = data.azurerm_resource_group.rsg.tags["product"]     
    description     = var.description     
    tracking_code   = var.tracking_code     
    cia             = var.cia   
  }
  sku {
    name     = var.sku_name 
    capacity = var.sku_capacity
    tier     = var.sku_tier
    family   = var.sku_family
  }

  storage_profile {
    storage_mb            = var.storage_mb
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup  = "Enabled"
    auto_grow             = "Enabled"
  }

  administrator_login          = local.admin_user
  administrator_login_password = random_string.password.result
  version                      = var.aps_version
  ssl_enforcement              = "Enabled"
  depends_on = [random_string.password]
}

data "azurerm_postgresql_server" "data_aps_server" {
  name                = var.server_name
  resource_group_name = var.resource_group
  depends_on = [azurerm_postgresql_server.aps_server]
}


resource "azurerm_postgresql_database" "aps_database" {
  name                = var.database_name
  resource_group_name = var.resource_group
  server_name         = data.azurerm_postgresql_server.data_aps_server.name
  charset             = var.charset_name
  collation           = var.collation_ddbb
  depends_on = [data.azurerm_postgresql_server.data_aps_server]
}


resource "azurerm_postgresql_virtual_network_rule" "aps_rule" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = var.resource_group
  server_name                          = data.azurerm_postgresql_server.data_aps_server.name
  subnet_id                            = var.subnet_id
  ignore_missing_vnet_service_endpoint = false
  depends_on = [data.azurerm_postgresql_server.data_aps_server]
}


resource "azurerm_monitor_diagnostic_setting" "dgm" {
  name                       = var.analytics_diagnostic_monitor
  target_resource_id         = data.azurerm_postgresql_server.data_aps_server.id
  log_analytics_workspace_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${var.lwk_resource_group_name}/providers/microsoft.operationalinsights/workspaces/${var.lwk_name}" 

  log {
    category = "PostgreSQLLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  log {
    category = "QueryStoreRuntimeStatistics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  log {
    category = "QueryStoreWaitStatistics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = "30"
    }
  }
  depends_on = [data.azurerm_postgresql_server.data_aps_server]
}
