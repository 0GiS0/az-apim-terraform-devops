provider "azurerm" {
  features {}
}

resource "random_pet" "service" {}

variable "location" {
  default = "westeurope"

}

resource "azurerm_resource_group" "rg" {
  name     = "api-management-demo"
  location = var.location
}

#API Management
resource "azurerm_api_management" "apim" {
  name                = random_pet.service.id
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = random_pet.service.id
  publisher_email     = "company@terraform.io"

  sku_name = "Developer_1"

  timeouts {
    create = "60m"
    delete = "60m"    

  }

  policy {
    xml_content = <<XML
<policies>
    <inbound>
       <cors allow-credentials="true">
          <allowed-origins>
              <origin>https://${random_pet.service.id}.developer.azure-api.net</origin>
          </allowed-origins>
          <allowed-methods preflight-result-max-age="300">
            <method>*</method>
          </allowed-methods>
          <allowed-headers>
              <header>*</header>
          </allowed-headers>
          <expose-headers>
              <header>*</header>
          </expose-headers>
        </cors>
    </inbound>
    <backend>
        <forward-request />
    </backend>
    <outbound />
    <on-error />
</policies> 
XML

  }
}
