resource "azurerm_api_management_backend" "starwars" {
  name                = "starwars-backend"
  description         = "Starwars backend"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  protocol            = "http"
  url                 = "https://swapi.dev/api/"
}


resource "azurerm_api_management_backend" "conference" {
  name                = "conference-backend"
  description         = "Conference backend"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  protocol            = "http"
  url                 = "https://conferenceapi.azurewebsites.net"
}
