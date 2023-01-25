resource "azurerm_public_ip" "public_ip" {
  name                = "vm_public_ip"
  resource_group_name = azurerm_resource_group.task-resource-group.name
  location            = azurerm_resource_group.task-resource-group.location
  allocation_method   = "Dynamic"
}