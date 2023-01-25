output "vm-pub-ip" {
  value = azurerm_linux_virtual_machine.task-vm.public_ip_address
}
