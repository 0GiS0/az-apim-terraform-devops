resource "azurerm_api_management_subscription" "demosub" {
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  # product_id          = azurerm_api_management_product.freemium.product_id
  display_name        = "Demo Subscription"
  state               = "active"
}

