resource "azurerm_api_management_tag" "indevelopment" {
  api_management_id = azurerm_api_management.apim.id
  name              = "in-development"
}

resource "azurerm_api_management_tag" "other_clouds" {
  api_management_id = azurerm_api_management.apim.id
  name              = "other-clouds"
}

resource "azurerm_api_management_tag" "on_prem" {
  api_management_id = azurerm_api_management.apim.id
  name              = "on-prem"
}