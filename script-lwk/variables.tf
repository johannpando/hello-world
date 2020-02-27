variable "resource_group" {
  type = string
  description = "(Required) The name of the resource group in which the Log Analytics workspace is created."
}

variable "name" {
  type        = string
  description = "(Required) Log Analytics workspace name. Do not forget to follow the naming conventions."
}

variable "location" {
  type        = string
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "westeurope"
}

variable "lwk_sku_name" {
    type        = string
    description = "(Required) Specifies the Sku of the Log Analytics Workspace. Possible value PerGB2018"
    default     = "PerGB2018"
  
}


#Tags

variable "channel" {
  type = string
  description = "(Optional) Distribution channel to which the associated resource belongs to."
  default     = ""
}


variable "description" {
  type = string
  description = "(Required) Provide additional context information describing the resource and its purpose."
}

variable "tracking_code" {
  type = string
  description = "(Optional) Allow this resource to be matched against internal inventory systems."
  default     = ""
}

variable "cia" {
  type        = string
  description = "(Required) Confidentiality-Integrity-Availability"
  
}


