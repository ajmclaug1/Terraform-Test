terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

resource "azurerm_resource_group" "bob" {
  name     = var.name
  location = "uksouth"
}


resource "azurerm_virtual_network" "bob" {
  name                = "myVnet"
  address_space       = var.vnet_address_space
  resource_group_name = azurerm_resource_group.bob.name
  location            = azurerm_resource_group.bob.location
  dns_servers         = [data.azurerm_firewall.example.ip_configuration[0].private_ip_address]
}



data "azurerm_firewall" "example" {
  name                = "firewall-hub"
  resource_group_name = "firewall-hub-RG"
}
