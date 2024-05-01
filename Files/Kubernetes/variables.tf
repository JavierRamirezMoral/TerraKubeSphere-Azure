
variable "resource_group_name" {
  type        = string
  default     = "az101"
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Resource location on Azure"
}

variable "aks_name" {
  type        = string
  default     = "aks01"
  description = "el nombre del AKS"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.28"
  description = "Kubernetes version"
}

variable "dns_prefix" {
  type        = string
  default     = "aks"
  description = "Value for DNS prefix passed in main.tf"
}

