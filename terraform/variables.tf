variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Location of the resources."
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "Environment type or name (will be used as tag)"
  type        = string
  default     = "production"
}

variable "client_secret" {
  description = "Client secret"
  type        = string
  default     = ""
}
variable "client_id" {
  description = "Client Id"
  type        = string
  default     = ""
}
variable "object_id" {
  description = "Object Id"
  type        = string
}
variable "tenant_id" {
  description = "Tenant Id"
  type        = string
}

variable "subscription_id" {
  description = "Subscription Id"
  type        = string
  default     = ""
}

variable "vm_size" {
  description = "VM size of aks nodes"
  type        = string
}

variable "k8s_version" {
  description = "Staging and production k8s version"
  type        = string
  default     = "1.29.4"
}