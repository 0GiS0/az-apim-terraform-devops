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

resource "azurerm_api_management_api_operation_policy" "starwars_starships_policy" {
  api_name            = azurerm_api_management_api.swapi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  operation_id        = azurerm_api_management_api_operation.starwars_starships.operation_id

  xml_content = <<XML
<policies>
  <outbound>
    <base />
    <set-header name="demo" exists-action="override">
        <value>Starship operation policy</value>
    </set-header>
  </outbound>
</policies>
XML

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

# People in space
resource "azurerm_api_management_api" "people_in_space" {
  name                = "people_in_space"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "People in space"
  path                = "people-in-space"
  protocols           = ["https"]
  service_url         = "http://api.open-notify.org"
}

resource "azurerm_api_management_api_operation" "people_in_space_get" {
  operation_id        = "people_in_space_get"
  api_name            = azurerm_api_management_api.people_in_space.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "Get People in space"
  method              = "GET"
  url_template        = "/astros.json"
  description         = "The number of people in space at this moment. List of names when known."
}

resource "azurerm_api_management_api_operation" "iss_location_get" {
  operation_id        = "iss_location_get"
  api_name            = azurerm_api_management_api.people_in_space.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  display_name        = "ISS Location Now"
  method              = "GET"
  url_template        = "/iss-now.json"
  description         = "Current ISS location over Earth (latitude/longitude)"
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

# Local API using gateway
resource "azurerm_api_management_api" "local_weather" {
  name                = "local_weather"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Local Weather API"
  path                = "local"
  protocols           = ["https"]
  service_url         = "http://172.17.0.3/weatherforecast" # IP address inside Docker network
}

resource "azurerm_api_management_api_tag" "local_weather_onprem" {
  api_id = azurerm_api_management_api.local_weather.id
  name   = azurerm_api_management_tag.on_prem.name
}

# Add this API to a gateway
resource "azurerm_api_management_gateway_api" "imac_local_weather" {
  gateway_id = data.azurerm_api_management_gateway.imac.id
  api_id     = data.azurerm_api_management_api.local_weather.id
}