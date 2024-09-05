###################### ResourceGroup ######################
data "azurerm_resource_group" "resource_group" {
  for_each = toset([
    "vwan12", "vwan13", "vwan14", "vwan15", "vwan16", "vwan17", "vwan18", "vwan19", "vwan20", "vwan21", "vwan22", "vwan23", "vwan24",
    "vwan25", "vwan26", "vwan27", "vwan28", "vwan29", "vwan30", "vwan31", "vwan32", "vwan33", "vwan34", "vwan35", "vwan36", "vwan37"
  ])
  name     = "${each.value}-training"
}



