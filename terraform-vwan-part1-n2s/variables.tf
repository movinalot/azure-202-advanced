variable "location" {
  description = "resource_group_location"
  type        = string
  default     = "eastus"
}

variable "size" {
  description = "size of VM"
  type        = string
  default     = "Standard_F2s_v2"
}

variable "publisher" {
  description = "Publisher of VM"
  type        = string
  default     = "fortinet"
}

variable "fgtoffer" {
  description = "offer of VM"
  type        = string
  default     = "fortinet_fortigate-vm_v5"
}

variable "fgtsku" {
  description = "fortigate plan"
  type        = string
  default     = "fortinet_fg-vm_payg_2023"
}

variable "fgtversion" {
  description = "version of VM"
  type        = string
  default     = "latest"
}

variable "adminusername" {
  description = "adminusername"
  type        = string
  default     = "fortixperts"
}

variable "adminpassword" {
  description = "adminpassword"
  type        = string
  default     = "Fortixperts2024!"
}