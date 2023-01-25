resource "azurerm_ssh_public_key" "task-ssh-key" {
  name                = "task-ssh-key"
  resource_group_name = azurerm_resource_group.task-resource-group.name
  location            = azurerm_resource_group.task-resource-group.location
  public_key          = file("~/.ssh/id_rsa.pub")
  
}
