variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "uksouth"

}

variable "service_plan_sku" {
  description = "The SKU of the service plan"
  type        = string
  default     = "F1"
}

variable "service_plan_os_type" {
  description = "The OS type of the service plan"
  type        = string
  default     = "Windows"
}

variable "managed_identity_ids" {
  description = "The IDs of the managed identities"
  type        = list(string)
  default     = []

}

variable "managed_identity_type" {
  description = "The type of the managed identity"
  type        = string
  default     = null

}
