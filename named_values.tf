resource "azurerm_api_management_named_value" "demo" {
  name                = "demo"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  display_name        = "demo"
  value               = "Hello, World! I'm a named value"
}

resource "azurerm_api_management_named_value" "demo_secret" {
  name                = "demo-secret"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  display_name        = "demo-secret"
  value               = "Hello, World! I'm a secret named value"
  secret = true
}