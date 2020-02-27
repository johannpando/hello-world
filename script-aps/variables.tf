locals {   
  admin_user = format("adm%s", var.server_name) 
}

#########PRODUCT VARIABLES#######

variable "database_name" {
  type        = string
  description = " (Required) Specifies the name of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."
}

variable "server_name" {
  type        = string
  description = "(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "analytics_diagnostic_monitor" {
  description = "(Mandatory) The name of the Analytics Diagnostic Monitor for PostgreSQL Server Monitor."
}

variable "lwk_name" {     
  description = "(Required) Specifies the name of a Log Analytics Workspace where Diagnostics Data should be sent." 
}

variable "lwk_resource_group_name" {
  description = "(Required) The name of the resource group the KVT and LWK are located in." 
}

/*
variable "kvt_name" {
     description = "(Required) The name of the kvt server where Admin User for PostgreSQL Server to save." 
}
*/

variable "key_vault_id" {
  description = "(required) Id of the kvt"  
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "sku_name" {
  type        = string
  description = " (Required) Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  default     = "GP_Gen5_4"
}

variable "sku_capacity" {
  type        = string
  description = "(Required) The scale up/out capacity, representing server's compute units."
  default     = "4"
}

variable "sku_tier" {
  type        = string
  description = "(Required) The tier of the particular SKU. Possible values are, GeneralPurpose, and MemoryOptimized."
  default     = "GeneralPurpose"
}

variable "sku_family" {
  type        = string
  description = "(Required) The family of hardware Gen4 or Gen5, before selecting your family check the product documentation for availability in your region."
  default     = "Gen5"
}

variable "storage_mb" {
  type        = string
  description = "(Required) Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs. "
  default     = "10240"
}


variable "backup_retention_days" {
  type        = string
  description = "(Optional) Backup retention days for the server, supported values are between 7 and 35 days."
  default     = "7"
}

variable "aps_version" {
  type        = string
  description = "(Required) Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created."
  default     = "11"
}

variable "charset_name" {
  type        = string
  description = " (Required) Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
  default     = "UTF8"
}

variable "collation_ddbb" {
  type        = string
  description = "(Required) Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  default = "default"
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the subnet that the PostgreSQL server will be connected to."
}



#tags
variable "cia" {
  type        = string
  description = "(Required) Allows a  proper data classification to be attached to the resource."
}

variable "channel" {
  type        = string
  description = "(Optional) Channel for Azure PostgreSQL."
}

variable "description" {
  type        = string
  description = "(Required) Provide additional context information describing the resource and its purpose."
}

variable "tracking_code" {
  type        = string
  description = "(Required) Allow Azure PostgreSQL to be matched against internal inventory systems."
}

