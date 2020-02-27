provider "azurerm" {
  version = "~>1.44"
}

data "azurerm_resource_group" "rsg" {
  name = var.resource_group
}

data "azurerm_log_analytics_workspace" "law" {
  name                = var.lwk_name
  resource_group_name = var.lwk_resource_group_name
}

data "azurerm_client_config" "current" {
}

output "account_id" {
  value = "${data.azurerm_client_config.current.tenant_id}"
}



resource "azurerm_template_deployment" "kvtcryp" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.rsg.name

  template_body = <<DEPLOY

{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "name": {            
            "type": "String",
            "metadata": {
                "description": "KeyVault name to create."
              }
        },
        "location": {            
            "type": "String",
            "metadata": {
                "description": "Location for the resources."
            }
        },
        "channel": {
            "type": "String",
            "metadata": {
                "description": "Distribution channel to which the associated resource belongs to."
              }
        },
        "cia": {
            "type": "String",
            "metadata": {
                "description": "Specifies the confidentiality,integrity and availability of the Azure Databricks."
              }
        },
        "description": {
            "type": "String",
            "metadata": {
                "description": "Provide additional context information describing the resource and its purpose."
              }
        },
        "tracking_code": {
            "type": "String",
            "metadata": {
                "description": "Allow this resource to be matched against internal inventory systems."
              }
        },
        "kvt_sku_name": {
            "type": "String",
            "metadata": {
                "description": "Select SKU for the Keyvault to create."
              }
        },
        "ObjectId": {
            "type": "String",
            "metadata": {
                "description": "Service Principal Object ID configured in devops pipeline."
              }
        },
        "tenantId": {
            "type": "String",
            "metadata": {
                "description": "Azure Tenant ID configured in devops pipeline."
              }
        }
    },
    "resources": [
        {
            "type": "Microsoft.KeyVault/vaults",
            "apiVersion": "2018-02-14",
            "name": "[parameters('name')]",
            "location": "[parameters('location')]",
            "tags": {
                "channel": "[parameters('channel')]",
                "description": "[parameters('description')]",
                "tracking_code": "[parameters('tracking_code')]"
            },
            "properties": {
                "tenantId": "[parameters('tenantId')]",
                "accessPolicies": [
                    {
                        "tenantId": "[parameters('tenantId')]",
                        "objectId": "[parameters('objectId')]",
                        "permissions": {
                            "keys": [
                                "encrypt",
                                "decrypt",
                                "wrapKey",
                                "unwrapKey",
                                "sign",
                                "verify",
                                "get",
                                "list",
                                "create",
                                "update",
                                "import",
                                "delete",
                                "backup",
                                "restore",
                                "recover",
                                "purge"
                            ],
                            "secrets": [
                                "get",
                                "list",
                                "set",
                                "delete",
                                "backup",
                                "restore",
                                "recover",
                                "purge"
                            ],
                            "certificates": [
                                "get",
                                "list",
                                "delete",
                                "create",
                                "import",
                                "update",
                                "managecontacts",
                                "getissuers",
                                "listissuers",
                                "setissuers",
                                "deleteissuers",
                                "manageissuers",
                                "recover",
                                "purge",
                                "backup",
                                "restore"
                            ],
                            "storage": [
                                "get",
                                "list",
                                "delete",
                                "set",
                                "update",
                                "regeneratekey",
                                "recover",
                                "purge",
                                "backup",
                                "restore",
                                "setsas",
                                "listsas",
                                "getsas",
                                "deletesas"
                            ]
                        }
                    }
                ],
                "enabledForDeployment": false,
                "enabledForDiskEncryption": true,
                "enabledForTemplateDeployment": true,
                "enableSoftDelete": true,
                "createMode": "default",
                "enablePurgeProtection": true,
                "sku": {
                    "name": "[parameters('kvt_sku_name')]",
                    "family": "A"
                },
                "networkAcls": {
                    "bypass": "AzureServices",
                    "defaultAction": "Allow"
                }
            }
        }
    ]
}

DEPLOY
  # these key-value pairs are passed into the ARM Template's `parameters` block
  parameters = {
    "name" = var.name
    "location" = var.location
    "channel" = var.channel
    "cia"  =     var.cia
    #"cost_center" = data.azurerm_resource_group.rsg.tags["cost_center"]
    #"product" = data.azurerm_resource_group.rsg.tags["product"]
    "description" = var.description
    "tracking_code" = var.tracking_code
    "kvt_sku_name" = var.kvt_sku_name
    "tenantId" = data.azurerm_client_config.current.tenant_id
    "objectId" = data.azurerm_client_config.current.service_principal_object_id

  }
  deployment_mode = "Incremental"
}

data "azurerm_key_vault" "kvt" {
  name = var.name
  resource_group_name = var.resource_group
  depends_on = ["azurerm_template_deployment.kvtcryp","data.azurerm_log_analytics_workspace.law"]
}


resource "azurerm_monitor_diagnostic_setting" "law" {
  name = var.analytics_diagnostic_monitor
  target_resource_id = data.azurerm_key_vault.kvt.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id

  log {
    category = "AuditEvent"
    enabled = true
    retention_policy {
      enabled = true
      days = "30"
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days = "30"
    }
  }
  depends_on = ["azurerm_template_deployment.kvtcryp","data.azurerm_log_analytics_workspace.law"]
}
