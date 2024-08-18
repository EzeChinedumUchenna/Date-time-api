/***# Application Gateway
resource "azurerm_application_gateway" "app_gateway" {
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Identity block to associate with the Managed Identity (Service Principal)
  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_id
  }

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "app_gateway_ip_config"
    subnet_id = var.app-gateway_subnet
  }

  frontend_port {
    name = "frontend_port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend_ip"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  backend_address_pool {
    name = "backend_pool"
  }

  http_listener {
    name                           = "http_listener"
    frontend_ip_configuration_name = "frontend_ip"
    frontend_port_name             = "frontend_port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing_rule"
    rule_type                  = "Basic"
    http_listener_name         = "http_listener"
    backend_address_pool_name  = "backend_pool"
    backend_http_settings_name = "backend_http_settings"
    priority                   = 100
  }

  backend_http_settings {
    name                  = "backend_http_settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
  }
}

# Public IP for Application Gateway
resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "app-gateway-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}




# Output the Application Gateway Public IP
output "app_gateway_public_ip" {
  value = azurerm_public_ip.app_gateway_public_ip.ip_address
}

# Output the Application Gateway Public IP
output "app_gateway_name" {
  value = azurerm_application_gateway.app_gateway.name
}***/