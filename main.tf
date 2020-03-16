terraform {
  backend "azurerm" {
    resource_group_name  = "sdip1weursggensyscomm001"
    storage_account_name = "sdip1weustagensyscomm001"
    container_name       = "gen-tfstates"
    key                  = "curasan.pre.terraform.tfstate"
  }
}

#-----Data Sources-----
data "azurerm_log_analytics_workspace" "lwk" {
  name                = module.lwk_module.lwk_name
  resource_group_name = module.lwk_module.lwk_resource_group
  depends_on          = [module.lwk_module]
}

/*data "azurerm_key_vault" "kvt" {
  name                = module.kvt_module.kvt_name
  resource_group_name = var.resource_group
  depends_on         = [module.kvt_module]
}*/

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

/*data "azurerm_storage_account" "sta" {
  name                = module.sta_module.sta_name
  resource_group_name = module.sta_module.sta_resource_group_name
  depends_on          = [module.sta_module]
}*/
/*data "azurerm_eventhub_namespace" "aeh" {
  name                = module.aeh_module.namespace_name
  resource_group_name = var.resource_group
  depends_on          = [module.aeh_module]
}*/

#-----LWK Module-----

module "lwk_module" {
  source = "./script-lwk"

  name                = "sdip1weulwk${var.name}comm001"
  resource_group      = var.resource_group 

  #Tags 
  channel                     = var.channel
  description                 = var.description
  tracking_code               = var.tracking_code
  cia                         = var.cia
}

#-----KVT Module-----

/*module "kvt_module" {
  source = "./script-kvt"
  
  name                         = "sdip1weukve${var.name}comm001"
  resource_group               = var.resource_group
  lwk_name                     = data.azurerm_log_analytics_workspace.lwk.name
  lwk_resource_group_name      = var.resource_group
  
  # Monitoring
  analytics_diagnostic_monitor = "kvt${var.name}dgm"

  # tags 
  channel                     = var.channel
  description                 = var.description
  tracking_code               = var.tracking_code
  cia                         = var.cia
}*/

#-----STA Module-----

/*module "sta_module" {
  source = "./script-sta"

  name                         = "sdip1weusta${var.name}comm001"
  resource_group               = var.resource_group
  kvt-key-name                 = "sta${var.name}key"

  # Data sources
  subnet_name                  = data.azurerm_subnet.subnet.name
  vnet_name                    = data.azurerm_subnet.subnet.virtual_network_name
  vnet_resource_group_name     = data.azurerm_subnet.subnet.resource_group_name
  kvt-name                     = data.azurerm_key_vault.kvt.name



  # Monitoring
  analytics_diagnostic_monitor = "sta${var.name}dgm"
  lwk-name                     = data.azurerm_log_analytics_workspace.lwk.name
  lwk_resource_group_name      = var.resource_group 

  # tags 
  channel                     = var.channel
  description                 = var.description
  tracking_code               = var.tracking_code
  cia                         = var.cia
}*/

#-----APS Module-----

module "aps_module" {
  source = "./script-aps"

  server_name                  = "sdip1weuaps${var.name}comm001"

  resource_group               = var.resource_group
  location                     = var.location

  # DB conf
  database_name                = "aps${var.name}db"
  sku_name                     = var.sku_name             
  sku_capacity                 = var.sku_capacity         
  sku_tier                     = var.sku_tier             
  sku_family                   = var.sku_family           
  storage_mb                   = var.storage_mb           
  backup_retention_days        = var.backup_retention_days
  aps_version                  = var.aps_version          
  charset_name                 = var.charset_name         
  collation_ddbb               = var.collation_ddbb       
  subnet_id                    = data.azurerm_subnet.subnet.id
  
  # Monitoring
  analytics_diagnostic_monitor = "aps${var.name}dgm" 
  lwk_resource_group_name      = var.resource_group 
  lwk_name                     = data.azurerm_log_analytics_workspace.lwk.name

  # Data sources
  key_vault_id                 = data.azurerm_key_vault.kvt.id

  # tags 
  channel                      = var.channel
  description                  = var.description
  tracking_code                = var.tracking_code
  cia                          = var.cia
}

#-----Cdb module-----
/*module "cdb_module" {
  source = "./script-cdb"

  name                         = "sdip1weucdb${var.name}comm001"
  resource_group               = var.resource_group

  # Monitoring
  analytics_diagnostic_monitor = "cdb${var.name}dgm" 
  lwk_resource_group_name      = var.resource_group 
  lwk_name                     = data.azurerm_log_analytics_workspace.lwk.name


  # tags 
  channel                      = var.channel
  description                  = var.description
  tracking_code                = var.tracking_code
  cia                          = var.cia  
}*/

#-----Appins module-----
module "appins_module" {
  source = "./script-appins"

  name                         = "sdip1weuais${var.name}comm001"
  resource_group               = var.resource_group

  key_vault_id                 = data.azurerm_key_vault.kvt.id

  # tags 
  channel                      = var.channel
  description                  = var.description
  tracking_code                = var.tracking_code
  cia                          = var.cia    
}

#-----AEH module-----
/*module "aeh_module" {
  source = "./script-aeh"

  name                         = "sdip1weuaeh${var.name}comm001"
  location                     = var.location
  resource_group               = var.resource_group
  
  #Specific config
  event_hub_snet_ids             = ["${data.azurerm_subnet.subnet.id}"] 
  event_hub_sku_tier             = var.event_hub_sku_tier
  event_hub_sku_capacity         = var.event_hub_sku_capacity
  event_hub_msg_retention        = var.event_hub_msg_retention
  event_hub_partition_count      = var.event_hub_partition_count
  event_hub_ips_filter           = var.event_hub_ips_filter
  
  # Monitoring  
  analytics_diagnostic_monitor   = "aeh${var.name}dgm" 
  lwk_resource_group_name        = var.resource_group 
  lwk_name                       = data.azurerm_log_analytics_workspace.lwk.name
  
  # tags   
  channel                        = var.channel
  description                    = var.description
  tracking_code                  = var.tracking_code
  cia                            = var.cia   
}*/
