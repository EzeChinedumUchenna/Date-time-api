variable "cluster_name" {
  description = "Name of the AKS Cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS Prefix for the AKS Cluster"
  type        = string
}

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the AKS Cluster"
  type        = string
}

variable "aks_subnet" {
  description = "ID of the Subnet to associate with AKS"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "vm_size" {
  description = "Size of the Virtual Machines in the node pool"
  type        = string
}

/**variable "app_gateway_name" {
  description = "Size of the Virtual Machines in the node pool"
  type        = string
}**/


/**variable "app-gateway_subnet_id" {
  description = "Size of the Virtual Machines in the node pool"
  type        = string
}**/




