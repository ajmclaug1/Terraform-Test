mock_provider "azurerm" {
  mock_data "azurerm_firewall" {
    defaults = {
      id                  = "firewall-hub-id"
      name                = "firewall-hub"
      resource_group_name = "firewall-hub-RG"
      ip_configuration = [
        {
          private_ip_address = "192.168.1.2"
        }
    ] }

  }
}


run "rg_tests" {
  assert {
    condition     = azurerm_resource_group.bob.name == "bobby"
    error_message = "name is not bobby"
  }
}

run "vnet_tests" {
  assert {
    condition     = azurerm_virtual_network.bob.name == "myVnet"
    error_message = "name is not myVnet"
  }

  assert {
    condition     = alltrue([for s in azurerm_virtual_network.bob.address_space : startswith(s, "192.168")])
    error_message = "incorrect address space name"
  }

  assert {
    condition     = azurerm_virtual_network.bob.dns_servers == tolist(["192.168.1.2"])
    error_message = "DNS servers are not set to the firewall IP"
  }
}

run "failing_tests" {

  command = plan
  variables {
    name = "bob"
  }

  expect_failures = [
    var.name,
  ]
}
