output "sta_name" {
  value = azurerm_storage_account.storage_account_service.name
}

output "sta_resource_group_name" {
  value = azurerm_storage_account.storage_account_service.resource_group_name
}