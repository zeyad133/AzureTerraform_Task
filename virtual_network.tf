resource "azurerm_virtual_network" "task-vn" {
  name                = "task-vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.task-resource-group.location
  resource_group_name = azurerm_resource_group.task-resource-group.name
}

resource "azurerm_subnet" "task-subnet" {
  name                 = "task-subnet"
  resource_group_name  = azurerm_resource_group.task-resource-group.name
  virtual_network_name = azurerm_virtual_network.task-vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "task-ni" {
  name                = "task-ni"
  location            = azurerm_resource_group.task-resource-group.location
  resource_group_name = azurerm_resource_group.task-resource-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.task-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}