provider "azurerm" {
  features {}
}

resource "random_pet" "service" { }

resource "azurerm_resource_group" "rg" {
  name     = "api-management-demo"
  location = "West Europe"
}

#API Management
resource "azurerm_api_management" "apim" {
  name                = random_pet.service.id
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = random_pet.service.id
  publisher_email     = "company@terraform.io"

  sku_name = "Developer_1"

  policy {
    xml_content = <<XML
<policies>
    <inbound>
        <cors>
            <allowed-origins>
                <origin>*</origin>
            </allowed-origins>
            <allowed-methods>
                <method>GET</method>
                <method>POST</method>
            </allowed-methods>
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