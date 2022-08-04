# Conference Demo API
resource "azurerm_api_management_api" "conference" {
  name                = "demo-conference-api"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Demo Conference API"
  path                = "conference"
  protocols           = ["https"]
  service_url         = "https://conferenceapi.azurewebsites.net"

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
}

#Policy
resource "azurerm_api_management_api_policy" "conference" {
  api_name            = azurerm_api_management_api.conference.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  xml_content = <<XML
<policies>
  <inbound>
    <find-and-replace from="xyz" to="abc" />
  </inbound>
</policies>
XML
}

# Add conference to freemium product
resource "azurerm_api_management_product_api" "conference" {
  product_id          = azurerm_api_management_product.freemium.product_id
  api_name            = azurerm_api_management_api.conference.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
}

#Starwars API
resource "azurerm_api_management_api" "swapi" {
  name                = "swapi"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "The Star Wars API"
  path                = "swapi"
  protocols           = ["https"]
  service_url         = "https://swapi.dev/api/"
}

##### Star Wars operations #####
resource "azurerm_api_management_api_operation" "starwars_people" {
  operation_id        = "people-get"
  api_name            = azurerm_api_management_api.swapi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Get People"
  method              = "GET"
  url_template        = "/people/{id}"
  description         = "A People resource is an individual person or character within the Star Wars universe."

  template_parameter {
    name          = "id"
    required      = true
    type          = "integer"
    description   = "The people id"
    default_value = 1
  }
}

resource "azurerm_api_management_api_operation" "starwars_starships" {
  operation_id        = "starships-get"
  api_name            = azurerm_api_management_api.swapi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Get Starship"
  method              = "GET"
  url_template        = "/starships/{id}"
  description         = "A Starship resource is a single transport craft that has hyperdrive capability."

  template_parameter {
    name          = "id"
    required      = true
    type          = "integer"
    description   = "The starship id"
    default_value = 12
  }
}


# Add Star Wars API to Freemium product
resource "azurerm_api_management_product_api" "starter_swapi" {
  api_name            = azurerm_api_management_api.swapi.name
  product_id          = azurerm_api_management_product.freemium.product_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
}

# Add tag
resource "azurerm_api_management_api_tag" "indevelopment" {
  api_id = azurerm_api_management_api.swapi.id
  name   = azurerm_api_management_tag.indevelopment.name
}

# Mock API
resource "azurerm_api_management_api" "mock" {
  name                = "mock"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Mock API"
  path                = "mock"
  protocols           = ["https"]
}

# Test call operation
resource "azurerm_api_management_api_operation" "mock_test_call" {
  operation_id        = "test"
  api_name            = azurerm_api_management_api.mock.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Test Call"
  method              = "GET"
  url_template        = "/test"

  response {
    status_code = 200
    description = "OK example"

    header {
      name     = "Content-Type"
      type     = "string"
      values   = ["application/json"]
      required = true
    }

    # Its not working
    representation {
      content_type = "application/json"

      example {
        name = "Luke Skywalker"
        value = jsonencode(
          {
            message = "Hello, I'm Luke Skywalker"
          }
        )
        summary = "json example"
      }

    }
  }
}

# Create policy for test call
resource "azurerm_api_management_api_operation_policy" "mock_test_call" {
  api_name            = azurerm_api_management_api.mock.name
  operation_id        = azurerm_api_management_api_operation.mock_test_call.operation_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <mock-response status-code="200" content-type="application/json" />
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

# return response operation
resource "azurerm_api_management_api_operation" "return_response" {
  operation_id        = "without-mock"
  api_name            = azurerm_api_management_api.mock.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Return-Response Approach"
  method              = "GET"
  url_template        = "/without-mock"

}

# Create policy for test call
resource "azurerm_api_management_api_operation_policy" "return_response_mock" {
  api_name            = azurerm_api_management_api.mock.name
  operation_id        = azurerm_api_management_api_operation.return_response.operation_id
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name

  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <choose>
            <when condition="@(context.Product.Name.Equals("Starter"))">
                <return-response>
                    <set-status code="401" reason="Unauthorized" />
                    <set-header name="WWW-Authenticate" exists-action="override">
                        <value>Bearer error="invalid_token"</value>
                    </set-header>
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="200" reason="OK" />
                    <set-body>new body value as text</set-body>
                </return-response>
            </otherwise>
        </choose>
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

