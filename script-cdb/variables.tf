variable "name" {
  type        = string
  description = "(Required) Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "offer_type" {
  type        = string
  description = "(Optional) Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard."
  default     = "Standard"
}

variable "geo_locations" {
  type        = list(string)
  description = "Failover Azure Regions, ordered by priority from major to minor."
  default     = ["northeurope"]
}

variable "capabilities" {
  type        = string
  description = "(Optional) The capabilities which should be enabled for this Cosmos DB account."
  default     = "EnableAggregationPipeline"
}

variable "ip_range_filter" {
  type        = string
  description = "(Optional) CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces."
  default     = null
}

variable "is_virtual_network_filter_enabled" {
  type        = bool
  description = "(Optional) Enables virtual network filtering for this Cosmos DB account."
  default     = null
}

variable "enable_automatic_failover" {
  type        = bool
  description = "(Optional) Enable automatic fail over for this Cosmos DB account."
  default     = null
}

variable "enable_multiple_write_locations" {
  type        = bool
  description = "(Optional) Enable multi-master support for this Cosmos DB account."
  default     = null
}

variable "lwk_name" {     
  description = "(Required) Specifies the name of a Log Analytics Workspace where Diagnostics Data should be sent." 
}

variable "lwk_resource_group_name" {
  description = "(Required) The name of the resource group the KVT and LWK are located in." 
}

variable "analytics_diagnostic_monitor" { 
}

variable "channel" {
  type        = string
  description = "(Optional) Distribution channel to which the associated resource belongs to."
  default     = ""
}

variable "description" {
  type        = string
  description = "(Required) Provide additional context information describing the resource and its purpose."
}

variable "tracking_code" {
  type        = string
  description = "(Required) Allow this resource to be matched against internal inventory systems."
}

variable "cia" {
  type        = string
  description = "(Required) Confidentiality-Integrity-Availability"
  
}

