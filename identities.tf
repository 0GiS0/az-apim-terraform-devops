variable "aad_client_id" {
  type      = string
  sensitive = true
}

variable "aad_client_secret" {
  type      = string
  sensitive = true
}

variable "aad_tenant_id" {
  type      = string
  sensitive = true
}

resource "azurerm_api_management_identity_provider_aad" "aad" {
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  client_id           = var.aad_client_id
  client_secret       = var.aad_client_secret
  allowed_tenants     = [var.aad_tenant_id]
  signin_tenant       = var.aad_tenant_id

}
