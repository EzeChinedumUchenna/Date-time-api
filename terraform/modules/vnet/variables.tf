variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "aks_subnet" {
  description = "Address range for the Subnet"
  type        = list(string)
}

variable "app-gateway_subnet" {
  description = "Address range for the Subnet"
  #type        = list(string)
}

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the Virtual Network"
  type        = string
}
