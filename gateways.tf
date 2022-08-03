resource "azurerm_api_management_gateway" "example" {
  name              = "imac-gateway"
  api_management_id = azurerm_api_management.apim.id
  description       = "iMac Gateway"

  location_data {
    name     = "iMac"
    city     = "Madrid"
    district = "San Sebastian de los Reyes"
    region   = "Spain"
  }
}
