output "posgresql_id" {   
    value = azurerm_postgresql_server.aps_server.id   
    description = "The ID of the PostgreSQL Server." 
} 
output "posgresql_fqdn" {   
    value = azurerm_postgresql_server.aps_server.fqdn 
    description = "The FQDN of the PostgreSQL Server." 
} 
output "aps_database" {   
    value = azurerm_postgresql_database.aps_database.id   
    description = "The ID of the PostgreSQL Database." 
} 
output "virtual_network_rule_id" {   
    value = azurerm_postgresql_virtual_network_rule.aps_rule.id   
    description = "The ID of the PostgreSQL Virtual Network Rule." 
}