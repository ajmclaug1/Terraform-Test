terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.0"
      }
    }
}

resource "azurerm_resource_group" "bob" {
    name = var.name
    location = "uksouth"
}

variable "name" {
    type = string
    validation {
    condition = contains(["bobby", "hank"], var.name)
    error_message = "not bobby or hank"
}
}