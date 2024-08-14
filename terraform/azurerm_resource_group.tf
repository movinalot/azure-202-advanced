###################### ResourceGroup ######################
data "azurerm_resource_group" "resource_group" {
  for_each = toset(["vwan12", "vwan13"])
  name     = "${each.value}-training"
}



