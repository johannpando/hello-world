provider "azurerm" {
  version = "~>1.44"
}

data "azurerm_resource_group" "lwk_rg" {
  name = var.resource_group
}

locals {
  location = var.location == null ? data.azurerm_resource_group.lwk_rg.location : var.location
  
}
resource "azurerm_log_analytics_workspace" "lwk" {
  name                = var.name
  location            = local.location
  resource_group_name = data.azurerm_resource_group.lwk_rg.name
  sku                 = var.lwk_sku_name

  tags = {
    #cost_center     = data.azurerm_resource_group.lwk_rg.tags["cost_center"]
    #product         = data.azurerm_resource_group.lwk_rg.tags["product"]
    channel         = var.channel
    description     = var.description
    tracking_code   = var.tracking_code
    cia             = var.cia
  }

}

