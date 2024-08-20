resource "azurerm_network_interface" "linuxvm-branch-nic1" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "Linux-Branch_nic1"
  location            = each.value.location
  resource_group_name = each.value.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.protectedsubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm-branch" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "Linux-Branch-VM"
  resource_group_name = each.value.name
  location            = each.value.location
  size                = "Standard_F2"
  admin_username      = var.adminusername
  network_interface_ids = [
    azurerm_network_interface.linuxvm-branch-nic1[each.key].id,
  ]

  admin_password = var.adminpassword

  os_disk {
    name                 = "Linux-Branch-VM-OS-Disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = ""
  }

  disable_password_authentication = false
}