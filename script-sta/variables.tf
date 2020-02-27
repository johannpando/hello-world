# Common variables
variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Storage Account. Changing this forces a new resource to be created. Must be globally unique. See CCoE Naming section for all restrictions."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Storage Account."
}

variable "location" {
  type        = string
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "westeurope"
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
  description = "(Required) Allows a  proper data classification to be attached to the resource."

}

variable "lwk-name" {
  type        = string
  description = "(Required) The name of a Log Analytics Workspace where Diagnostics Data should be sent."
}

variable "kvt-name" {
  type        = string
  description = "(Required) The name of a KVT where manage keys and access policies."
}


variable "kvt-key-name" {
  type        = string
  description = "(Required) The name of a key from a KVT to connect with the Storage Account Product."
}


variable "lwk_resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group the KVT and LWK are located in."
}
locals {
  kvt-url = format("https://%s.vault.azure.net/", var.kvt-name)
}
#Custom variables

variable "account_tier" {
  type        = string
  description = "(Required) Storage account access kind [ Standard | Premium ]."
  default     = "Standard"
}

variable "access_tier" {
  type        = string
  description = "(Optional) Storage account access tier for BlobStorage accounts [ Hot | Cool ]"
  default     = "Hot"
}

variable "account_replication_type" {
  type        = string
  description = "(Required)  Storage account replication type [ LRS ZRS GRS RAGRS ]"
  default     = "ZRS"
}

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

variable "analytics_diagnostic_monitor" {}
variable "ip_rules" {
  default     = "100.0.0.1/30"
}
