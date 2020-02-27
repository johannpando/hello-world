# Product variables
variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Event Hub. Changing this forces a new resource to be created. Must be globally unique. See CCoE Naming section for all restrictions."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Event Hub."  
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

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

variable "event_hub_snet_ids" {
  type        = list(string)
  description = "(Optional) List of SubNets Ids."
}

# Analytics Variables
/*
variable "log_analytics_workspace_id" {
  type = string
  description = "(Required) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
}
*/
variable "lwk_resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group the LWK are located in."
}

variable "lwk_name" {
  description = "(Mandatory) Log Work Space Name to connect the product."
}

variable "analytics_diagnostic_monitor" {
  type        = string
  description = "(Required) Specifies the name of the Diagnostic Setting. Changing this forces a new resource to be created."
}


# Custom tags
variable "cia" {
  type        = string
  description = "(Mandatory) Specifies the confidentiality,integrity and availability of the Azure Event Hub."
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
  description = "(Optional) Allow this resource to be matched against internal inventory systems."
  default     = ""
}
