provider "azurerm" {
  version = "~>1.44"
}
# Resource Groups
data "azurerm_resource_group" "main" {
  name = var.resource_group
}
/* 
data "azurerm_key_vault" "main" {
  name                = var.kvt_name
  resource_group_name = data.azurerm_resource_group.main.name
}
*/
# Product
resource "azurerm_application_insights" "main" {
  name                = var.name
  location            = var.location == "" ? data.azurerm_resource_group.main.location : var.location
  resource_group_name = data.azurerm_resource_group.main.name
  application_type    = var.application_type

  tags = {
    #cost_center     = data.azurerm_resource_group.main.tags["cost_center"]
    #product         = data.azurerm_resource_group.main.tags["product"]
    cia             = var.cia
    description     = var.description
    tracking_code   = var.tracking_code
    channel         = var.channel
  }
}
resource "azurerm_key_vault_secret" "credentials" {
  name          = azurerm_application_insights.main.name
  value         = azurerm_application_insights.main.instrumentation_key
  key_vault_id  = var.key_vault_id
  #key_vault_id  = data.azurerm_key_vault.main.id
}