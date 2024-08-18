module "resource_group" {
  source    = "./modules/resource_group"
  rg_name   = var.rg_name
  location  = var.location
}

module "network" {
  source               = "./modules/vnet"
  rg_name              = module.resource_group.name
  location             = module.resource_group.location
  subnet_name          = var.subnet_name
  vnet_name            = var.vnet_name
  address_space        = var.address_space
  aks_subnet           = var.aks_subnet
  app-gateway_subnet   = var.app-gateway_subnet
}

module "nsg" {
  source         = "./modules/nsg"
  rg_name        = module.resource_group.name
  location       = module.resource_group.location
  nsg_name       = var.nsg_name
  subnet_id      = module.network.subnet_id
}

module "nat-gateway" {
  source              = "./modules/nat-gateway"
  name                = var.name
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.network.subnet_id
}


/***module "app_gateway_agic" {
  source          = "./modules/applicationGateway-Ingress"
  location        = module.resource_group.location
  app-gateway_subnet   = module.network.app-gateway_subnet_id
  app_gateway_name = var.app_gateway_name
  resource_group_name = module.resource_group.name
  identity_id = [module.iam.app_gateway_identity_id]

  
}***/

module "aks" {
  source          = "./modules/aks"
  rg_name         = module.resource_group.name
  location        = module.resource_group.location
  cluster_name    = var.cluster_name
  dns_prefix      = var.dns_prefix
  aks_subnet     = module.network.subnet_id
  node_count      = var.node_count
  vm_size         = var.vm_size
  #app_gateway_name= module.app_gateway_agic.app_gateway_name
  #app-gateway_subnet_id   = module.network.app-gateway_subnet_id
  
}



module "iam" {
  source              = "./modules/iam"
  aks_client_id       = module.aks.client_id
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  appGW-Network-scope = module.network.app-gateway_subnet_id
}


module "deployments" {
  source              = "./modules/deployments"
  namespace           = "api-namespace"
  deployment_name     = "api-deployment"
  service_name        = "api-service"
  image               = "nginx"
  replicas            = 1
}

#######################################################
# TERRAFORM OUTPUT 
#######################################################



output "kube_config" {
  description = "Kubeconfig file to interact with the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "nat_gateway_id" {
  value = module.nat-gateway.nat_gateway_id
}

