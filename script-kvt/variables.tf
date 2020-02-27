variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the Azure Key Vault."
}

variable "location" {
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "westeurope"
}

variable "lwk_resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group the KVT and LWK are located in."
}

variable "name" {
  description = "(Required) Specifies the name of the Key Vault. See CCoE Naming section for all restrictions."
}

variable "analytics_diagnostic_monitor" {
  description = "(Mandatory) Specifies the monitor diagnostic name."
}



variable "kvt_sku_name" {
  description = "(Mandatory) SKU name to specify whether the key vault is a standard vault or a premium vault."
  default     = "Premium"
}

variable "lwk_name" {
  description = "(Mandatory) Log Work Space Name to connect the product."
}

#Custom tags

variable "channel" {
  description = "(Optional) Channel for Azure Key Vault."
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
