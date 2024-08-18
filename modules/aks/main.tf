resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.aks_subnet
  }

  identity {
    type = "SystemAssigned"
  }

   /**ingress_application_gateway {
      gateway_name      = var.app_gateway_name
      subnet_id       = var.app-gateway_subnet_id
      
    
  }**/

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    load_balancer_sku = "standard"
  }

   
}








output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0]
}




/**output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

}**/

# Use this if your AKS uses a Managed Identity or use the next one that is commented out
output "client_id" {
  description = "The Client ID for the AKS cluster's managed identity"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

/**output "client_id" {
  description = "The Client ID for the AKS cluster's service principal"
  value       = azurerm_kubernetes_cluster.aks.service_principal[0].client_id
}**/


