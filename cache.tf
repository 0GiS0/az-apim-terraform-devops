resource "azurerm_redis_cache" "cache" {
  name                = random_pet.service.id
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}

resource "azurerm_api_management_redis_cache" "apim_cache" {
  name              = random_pet.service.id
  api_management_id = azurerm_api_management.apim.id
  connection_string = azurerm_redis_cache.cache.primary_connection_string
  description       = "Redis cache instances"
  redis_cache_id    = azurerm_redis_cache.cache.id
  cache_location    = var.location


  timeouts {
    create = "60m"
    delete = "60m"    

  }

}
