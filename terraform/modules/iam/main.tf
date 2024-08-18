# Data source to retrieve the subscription ID
data "azurerm_subscription" "primary" {}

# Data source to retrieve the current user's object ID
data "azurerm_client_config" "current_user" {}


# IAM Role Assignment for the AKS Managed Identity
resource "azurerm_role_assignment" "aks_contributor" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "owner"
  principal_id         = var.aks_client_id
}

# IAM Role Assignment for the User running the terraform script
resource "azurerm_role_assignment" "user_reader_role" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.current_user.object_id
}



#####
 #Create a Managed Identity. This identity represents the Service Principal that the Application Gateway will use.
resource "azurerm_user_assigned_identity" "app_gateway_identity" {
  name                = "app-gateway-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "app_gateway_network_contributor" {
  scope                = var.appGW-Network-scope
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.app_gateway_identity.principal_id
}











output "app_gateway_identity_id" {
  description = "Id of the Network contributor role for app gatway service principle"
  value = azurerm_user_assigned_identity.app_gateway_identity.id
}


output "Managed-Identity_aks_contributor_role_assignment_id" {
  description = "ID of the Contributor role assignment"
  value       = azurerm_role_assignment.aks_contributor.id
}

output "user-reader_role_assignment_id" {
  description = "ID of the Network Contributor role assignment"
  value       = azurerm_role_assignment.user_reader_role.id
}
