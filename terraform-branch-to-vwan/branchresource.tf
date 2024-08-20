// Create Virtual Network

resource "azurerm_virtual_network" "fgtvnetwork" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "Branch_VNET"
  address_space       = ["172.31.1.0/24"]
  location            = each.value.location
  resource_group_name = each.value.name
}

resource "azurerm_subnet" "publicsubnet" {
  for_each             = data.azurerm_resource_group.resource_group
  name                 = "Public-Branch_SUBNET"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork[each.key].name
  address_prefixes     = ["172.31.1.0/28"]
}

resource "azurerm_subnet" "privatesubnet" {
  for_each             = data.azurerm_resource_group.resource_group
  name                 = "Private-Branch_SUBNET"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork[each.key].name
  address_prefixes     = ["172.31.1.16/28"]
}

resource "azurerm_subnet" "protectedsubnet" {
  for_each             = data.azurerm_resource_group.resource_group
  name                 = "Protected-Branch_SUBNET"
  resource_group_name  = each.value.name
  virtual_network_name = azurerm_virtual_network.fgtvnetwork[each.key].name
  address_prefixes     = ["172.31.1.32/28"]
}

// Allocated Public IP
resource "azurerm_public_ip" "FGTPublicIp" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "FortiGate-Branch_PIP"
  location            = var.location
  resource_group_name = each.value.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

//  Network Security Group
resource "azurerm_network_security_group" "publicnetworknsg" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "FortiGate-Branch-public_NSG"
  location            = var.location
  resource_group_name = each.value.name

  security_rule {
    name                       = "TCP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "privatenetworknsg" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "FortiGate-Branch-private_NSG"
  location            = each.value.location
  resource_group_name = each.value.name

  security_rule {
    name                       = "All"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_rule" "outgoing_public" {
  for_each                    = data.azurerm_resource_group.resource_group
  name                        = "egress"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = each.value.name
  network_security_group_name = azurerm_network_security_group.publicnetworknsg[each.key].name
}

resource "azurerm_network_security_rule" "outgoing_private" {
  for_each                    = data.azurerm_resource_group.resource_group
  name                        = "egress-private"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = each.value.name
  network_security_group_name = azurerm_network_security_group.privatenetworknsg[each.key].name
}

// FGT Network Interface port1
resource "azurerm_network_interface" "fgtport1" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "fgtport1"
  location            = each.value.location
  resource_group_name = each.value.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.publicsubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp[each.key].id
  }
}

resource "azurerm_network_interface" "fgtport2" {
  for_each              = data.azurerm_resource_group.resource_group
  name                  = "fgtport2"
  location              = each.value.location
  resource_group_name   = each.value.name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.privatesubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}


# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  for_each                  = azurerm_network_interface.fgtport1
  network_interface_id      = azurerm_network_interface.fgtport1[each.key].id
  network_security_group_id = azurerm_network_security_group.publicnetworknsg[each.key].id
}

resource "azurerm_network_interface_security_group_association" "port2nsg" {
  for_each                  = azurerm_network_interface.fgtport1
  network_interface_id      = azurerm_network_interface.fgtport2[each.key].id
  network_security_group_id = azurerm_network_security_group.privatenetworknsg[each.key].id
}