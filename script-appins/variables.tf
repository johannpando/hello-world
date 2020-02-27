# Product variables
variable "name" {
  type = string
  description = "(Required) Specifies the name of the Virtual Machine Scaleset. Changing this forces a new resource to be created. Must be globally unique. See CCoE Naming section for all restrictions."
}
variable "resource_group" {
  type = string
  description = "(Required) The name of the resource group in which to create the VMSS."
}
variable "location" {
  type = string
  description = "(Optional) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default = ""
}
variable "application_type" {
  type = string
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET"
  default     = "Java"
}
/*
variable "kvt_name" {
  type = string
  description = "(Required) Specifies the name of the workload key vault."
}
*/

variable "key_vault_id" {
  description = "(required) Id of the kvt"  
}
# Custom tags
variable "channel" {
  type = string
  description = "(Required) This tag will indicate the distribution channel to which the associated resource belongs to."
}
variable "description" {
  type = string
  description = "(Required) Provide additional context information describing the resource and its purpose."
}
variable "tracking_code" {
  type = string
  description = "(Required) Allow Data Factory to be matched against internal inventory systems."
}
variable "cia" {
  type        = string
  description = "(Mandatory) Specifies the confidentiality,integrity and availability of the Azure MySQL Server."
}