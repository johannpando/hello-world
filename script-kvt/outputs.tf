output "kvt_name" {
  value = azurerm_template_deployment.kvtcryp.name
}
output "kvt_resource_group" {
  value = data.azurerm_key_vault.kvt.resource_group_name
}
