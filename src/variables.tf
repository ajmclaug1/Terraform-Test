
variable "name" {
  type = string
  validation {
    condition     = contains(["bobby", "hank"], var.name)
    error_message = "not bobby or hank"
  }
}


variable "vnet_address_space" {
  type = list(string)
  validation {
    condition     = alltrue([for s in var.vnet_address_space : startswith(s, "192.168")])
    error_message = "address space must start with 192.168"
  }
}
