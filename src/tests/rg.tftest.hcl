mock_provider "azurerm" {

}

run "tests"{
    assert{
        condition = azurerm_resource_group.bob.name == "bobby"
        error_message = "name is not bobby"
    }
}
run "failing_tests"{

  command = plan
  variables {
    name = "peter"
  }

  expect_failures = [
    var.name,
  ]
}