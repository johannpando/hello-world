#-----Common variables-----
variable "name" {
  type        = string
  description = "(Required) The name of the product"
}

variable "location" {
  type        = string
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new product to be created."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Product."
}

#-----Vnet vars-----
variable "vnet_name" {
  type        = string
  description = "(Required) The name of the Virtual Network the Storage Account is located in."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group the Virtual Network is located in."
}

variable "subnet_name" {
  type        = string
  description = "(Required) The name of the Subnetal the Storage Account is located in."
}

#-----PSA vars-----

variable "sku_name" {
  type        = string
  description = " (Required) Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  default     = "GP_Gen5_2"
}

variable "sku_capacity" {
  type        = string
  description = "(Required) The scale up/out capacity, representing server's compute units."
  default     = "2"
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
  default     = "128000"
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

#-----AEH variables-----
variable "event_hub_sku_tier" {
  type        = string
  description = "(Required) Specifies the tier of the Event Hub."
  default     = "Standard"
}

variable "event_hub_sku_capacity" {
  type = number
  default = 1
  description = "(Required) Specifies the capacity."
}

variable "event_hub_msg_retention" {
  type = number
  default = 7
  description = "(Required) Specifies the message retention."
}

variable "event_hub_partition_count" {
  type = number
  default = 1
  description = "(Required) Specifies the number of partitions."
}

variable "event_hub_ips_filter" {
  type        = list(string)
  description = "(Optional) List of IPs filter."
  default     = ["180.49.44.1","180.49.40.1","180.49.56.1/24"]
}

#-----Custom tags-----

variable "channel" {
  description = "(Optional) Channel for resources."
}

variable "description" {
  description = "(Optional) Provide additional context information describing the resource and its purpose."
}

variable "tracking_code" {
  description = "(Optional) Allow  to be matched against internal inventory systems."
}

variable "cia" {
  type        = string
  description = "(Required) Confidentiality-Integrity-Availability"
  
}