output "cosmos-db-id" {
  value = "${azurerm_cosmosdb_account.main.id}"
}

output "cosmos-db-endpoint" {
  value = "${azurerm_cosmosdb_account.main.endpoint}"
}

output "cosmos-db-endpoints_read" {
  value = "${azurerm_cosmosdb_account.main.read_endpoints}"
}

output "cosmos-db-endpoints_write" {
  value = "${azurerm_cosmosdb_account.main.write_endpoints}"
}

output "cosmos-db-primary_master_key" {
  value = "${azurerm_cosmosdb_account.main.primary_master_key}"
}

output "cosmos-db-secondary_master_key" {
  value = "${azurerm_cosmosdb_account.main.secondary_master_key}"
}
