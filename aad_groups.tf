resource "azurerm_api_management_group" "breaking_bad" {
  name                = "breaking-bad"
  display_name        = "Breaking Bad"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  external_id         = "aad://returngis.onmicrosoft.com/groups/f450b5dc-6e8d-497b-a2d0-0ae27260bb52"
  type                = "external"
}


resource "azurerm_api_management_group" "dharma_initiative" {
  name                = "dharma-initiative"
  display_name        = "Dharma Initiative"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  external_id         = "aad://returngis.onmicrosoft.com/groups/979c947a-35b2-4523-839c-f730f05cc4db"
  type                = "external"
}


resource "azurerm_api_management_group" "gotham" {
  name                = "gotham"
  display_name        = "Gotham"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  external_id         = "aad://returngis.onmicrosoft.com/groups/136a560b-6b5f-4c68-9871-8f6bd1be6571"
  type                = "external"
}
