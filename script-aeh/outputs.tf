output "namespace_name" {
  value = "${azurerm_eventhub_namespace.eventhubns.name}"
}
output "eventhub_name" {
  value = "${azurerm_eventhub.eh.name}"
}
output "consumer_group" {
  value = "${azurerm_eventhub_consumer_group.ehconsumergroup.name}"
}