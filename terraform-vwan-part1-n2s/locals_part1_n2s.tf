locals {
    resource_group_names = toset(["vwan12", "vwan13", "vwan14"])
    hub_address_space = "10.1.0.0/16"
}