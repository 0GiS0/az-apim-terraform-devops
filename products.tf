resource "azurerm_api_management_product" "freemium" {
  product_id            = "freemium"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Freemium"
  subscription_required = true
  subscriptions_limit   = 1
  approval_required     = false
  published             = true

}

resource "azurerm_api_management_product" "basic" {
  product_id            = "basic"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Basic"
  subscription_required = true
  approval_required     = true
  published             = true

}

resource "azurerm_api_management_product" "standard" {
  product_id            = "standard"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Standard"
  subscription_required = true
  approval_required     = true
  published             = true

}

resource "azurerm_api_management_product" "premium" {
  product_id            = "premium"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Premium"
  subscription_required = true
  approval_required     = true
  published             = true

}
