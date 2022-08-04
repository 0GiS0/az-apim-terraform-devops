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

resource "azurerm_api_management_product_policy" "freemium_policy" {
  product_id          = azurerm_api_management_product.freemium.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name

  xml_content = <<XML
<policies>
    <inbound>
        <quota-by-key calls="5" renewal-period="300" counter-key="@(context.Request.IpAddress)" />
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML

}

resource "azurerm_api_management_product_api" "conference_to_freemium" {
  api_name            = azurerm_api_management_api.conference.name
  product_id          = azurerm_api_management_product.freemium.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_product_api" "swapi_to_freemium" {
  api_name            = azurerm_api_management_api.swapi.name
  product_id          = azurerm_api_management_product.freemium.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}


resource "azurerm_api_management_product" "basic" {
  product_id            = "basic"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Basic"
  subscription_required = true
  subscriptions_limit   = 1
  approval_required     = true
  published             = true

}

resource "azurerm_api_management_product_policy" "basic_policy" {
  product_id          = azurerm_api_management_product.basic.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name

  xml_content = <<XML
<policies>
    <inbound>
        <rate-limit calls="5" renewal-period="60" />
        <quota calls="100" renewal-period="604800" />
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML

}

resource "azurerm_api_management_product_api" "conference_to_basic" {
  api_name            = azurerm_api_management_api.conference.name
  product_id          = azurerm_api_management_product.basic.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_product_api" "swapi_to_basic" {
  api_name            = azurerm_api_management_api.swapi.name
  product_id          = azurerm_api_management_product.basic.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_product" "standard" {
  product_id            = "standard"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Standard"
  subscription_required = true
  subscriptions_limit   = 1
  approval_required     = true
  published             = true

}

resource "azurerm_api_management_product_policy" "standard_policy" {
  product_id          = azurerm_api_management_product.standard.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name

  xml_content = <<XML
<policies>
    <inbound>        
        <quota calls="200" renewal-period="604800" />
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML

}

resource "azurerm_api_management_product_api" "conference_to_standard" {
  api_name            = azurerm_api_management_api.conference.name
  product_id          = azurerm_api_management_product.standard.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_product_api" "swapi_to_standard" {
  api_name            = azurerm_api_management_api.swapi.name
  product_id          = azurerm_api_management_product.standard.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_product" "premium" {
  product_id            = "premium"
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = azurerm_resource_group.rg.name
  display_name          = "Premium"
  subscription_required = true
  subscriptions_limit   = 1
  approval_required     = true
  published             = true

}

resource "azurerm_api_management_product_policy" "premium_policy" {
  product_id          = azurerm_api_management_product.premium.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name

  xml_content = <<XML
<policies>
    <inbound>        
        <quota calls="500" renewal-period="604800" />
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML

}

resource "azurerm_api_management_product_api" "conference_to_premium" {
  api_name            = azurerm_api_management_api.conference.name
  product_id          = azurerm_api_management_product.premium.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}

resource "azurerm_api_management_product_api" "swapi_to_premium" {
  api_name            = azurerm_api_management_api.swapi.name
  product_id          = azurerm_api_management_product.premium.product_id
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
}
