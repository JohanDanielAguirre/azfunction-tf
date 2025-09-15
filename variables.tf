variable "name_function" {
  type        = string
  description = "Name Function"
}

variable "location" {
  type        = string
  default     = "mexicocentral"
  description = "Location"
}

variable "vm_name" {
  type    = string
  default = "mi-vm-linux"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type    = string
  default = "P@ssw0rd1234!" # OJO: Para pruebas. Lo ideal es usar SSH keys
}