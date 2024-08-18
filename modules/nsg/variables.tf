variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the Network Security Group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the Subnet to associate with NSG"
  type        = string
}
