resource "azurerm_virtual_wan" "vwan" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "${each.key}-${each.value.location}_VWAN"
  resource_group_name = each.value.name
  location            = each.value.location
}

resource "azurerm_virtual_hub" "vhub" {
  for_each            = data.azurerm_resource_group.resource_group
  name                = "${each.key}-vHub1_${each.value.location}"
  resource_group_name = each.value.name
  location            = each.value.location
  virtual_wan_id      = azurerm_virtual_wan.vwan[each.key].id
  address_prefix      = "10.1.0.0/16"
}

