resource "azurerm_linux_virtual_machine" "task-vm" {
  name                = "task-virtual-machine"
  resource_group_name = azurerm_resource_group.task-resource-group.name
  location            = azurerm_resource_group.task-resource-group.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.task-ni.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = azurerm_ssh_public_key.task-ssh-key.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
    provisioner "remote-exec" {
       inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx"]
    }
    connection {
      type = "ssh"
      user = "adminuser"
      private_key = "${file("~/.ssh/id_rsa")}"
      host = self.public_ip_address    
    }
}
