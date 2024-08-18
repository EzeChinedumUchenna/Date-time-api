variable "aks_client_id" {
  description = "Client ID of the AKS service principal or managed identity"
  type        = string
}

variable resource_group_name {}
variable location {}



variable "appGW-Network-scope" {
  description = "this is the scope the appliacation gateway service principle cover"
}