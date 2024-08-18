resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name
}
# Subnet for AKS nodes
resource "azurerm_subnet" "subnet" {
  name                 = "${var.subnet_name}-AKS-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.aks_subnet
  #enforce_private_link_endpoint_network_policies = true
}

# Subnet for Application Gateway
resource "azurerm_subnet" "app-gateway_subnet" {
  name                 = "${var.subnet_name}-app-gateway-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app-gateway_subnet

}



output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "app-gateway_subnet_id" {
  value = azurerm_subnet.app-gateway_subnet.id
}

output "app-gateway_subnet_name" {
  value = azurerm_subnet.app-gateway_subnet.name
}

