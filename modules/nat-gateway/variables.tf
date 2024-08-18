variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "location" {
  description = "Location for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate with the NAT gateway"
  type        = string
}
