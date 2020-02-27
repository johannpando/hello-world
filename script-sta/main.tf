data "azurerm_resource_group" "rsg" {
  name = var.resource_group
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_key_vault" "kvt" {
  name                 = var.kvt-name
  resource_group_name  = data.azurerm_resource_group.rsg.name
}

resource "azurerm_storage_account" "storage_account_service" {
  name                      = var.name
  resource_group_name       = data.azurerm_resource_group.rsg.name
  location                  = var.location == "" ? data.azurerm_resource_group.rsg.location : var.location
  account_kind              = "StorageV2"
  account_tier              = var.account_tier
  access_tier               = var.access_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true
  enable_blob_encryption    = true

  identity {
    type = "SystemAssigned"
    }

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [data.azurerm_subnet.subnet.id]
    bypass                     = ["Logging","Metrics","AzureServices"]
    ip_rules                   = [var.ip_rules]
  }
/*
  tags = {
    cost_center         = data.azurerm_resource_group.rsg.tags["cost_center"]
    product             = data.azurerm_resource_group.rsg.tags["product"]
    channel             = var.channel
    description         = var.description
    tracking_code       = var.tracking_code
    cia = var.cia
  }
*/
}

data "azurerm_log_analytics_workspace" "law" {
  name                = var.lwk-name
  resource_group_name = var.lwk_resource_group_name
}


resource "azurerm_monitor_diagnostic_setting" "testLG" {
  name                       = var.analytics_diagnostic_monitor
  target_resource_id         = azurerm_storage_account.storage_account_service.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
  depends_on = ["azurerm_storage_account.storage_account_service"] 
}

resource "azurerm_key_vault_access_policy" "kvt_access_policy" {
  vault_name          = var.kvt-name
  resource_group_name = data.azurerm_resource_group.rsg.name

  tenant_id = azurerm_storage_account.storage_account_service.identity.0.tenant_id
  object_id = azurerm_storage_account.storage_account_service.identity.0.principal_id

  key_permissions = [
    "get", "wrapkey","unwrapkey", "encrypt","decrypt"
  ]

  depends_on = ["azurerm_storage_account.storage_account_service"] 
}


resource "azurerm_key_vault_key" "generated" {
  name      = var.kvt-key-name
  key_vault_id = "${data.azurerm_key_vault.kvt.id}"
  key_type  = "RSA"
  key_size  = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}


resource "azurerm_template_deployment" "StorageAccountEncryptUsingKeyVault" {
  resource_group_name = var.resource_group
  name = azurerm_storage_account.storage_account_service.name
  

  
  template_body = <<DEPLOY

{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "name": {
            "type": "String"
      },
      "location": {
            "type": "String"
        },"kvt-url": {
            "type": "String"
        },
        "kvt-key-name": {
            "type": "String"
        },
        "kvt-key-version": {
            "type": "String"
        }},
        "variables": {},
    "resources": [
        {
            "name": "[parameters('name')]",
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2018-07-01",
            "location": "[parameters('location')]",
            "properties": {
                "encryption": {
                    "keySource": "Microsoft.Keyvault",
                    "keyvaultproperties": {
                        "keyname": "[parameters('kvt-key-name')]",
                        "keyversion": "[parameters('kvt-key-version')]",
                        "keyvaulturi": "[parameters('kvt-url')]"
                    }
                }
            },
        
      
      "dependsOn": []
        }
  ]
}
DEPLOY


  # these key-value pairs are passed into the ARM Template's `parameters` block
  parameters = {
    name = azurerm_storage_account.storage_account_service.name
    location = var.location
    kvt-url = local.kvt-url
    kvt-key-name = var.kvt-key-name
    kvt-key-version = azurerm_key_vault_key.generated.version

  }
  deployment_mode = "Incremental"

  depends_on = ["azurerm_storage_account.storage_account_service","azurerm_key_vault_key.generated","azurerm_key_vault_access_policy.kvt_access_policy"] 
}



