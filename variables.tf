variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "aks-custom-rg"
}

variable "location" {
  description = "Location of the resources"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "aks-vnet"
}

variable "address_space" {
  description = "Address space for the VNET"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "aks_subnet" {
  description = "Address space for the Subnet for cluster"
  type        = list(string)
  default     = ["10.240.0.0/16"]
}

variable "app-gateway_subnet" {
  description = "Address space for the subnet for application gateway & AGIC"
  type        = list(string)
  default     = ["10.241.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "aks-subnet"
}


variable "name" {
  description = "Prefix for resources"
  type        = string
  default     = "aks"
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "aks-nsg"
}

variable "cluster_name" {
  description = "Name of the AKS Cluster"
  type        = string
  default     = "aks-cluster"
}

variable "dns_prefix" {
  description = "DNS Prefix for the AKS Cluster"
  type        = string
  default     = "aks-custom"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Size of the Virtual Machines in the node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "app_gateway_name" {
  description = "Size of the Virtual Machines in the node pool"
  type        = string
  default     = "appGw-Ingress"
}

