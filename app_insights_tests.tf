# Test Star Wars API
resource "azurerm_application_insights_standard_web_test" "swapi_test" {

    name = "swapi_test"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    application_insights_id = azurerm_application_insights.appinsights.id

    geo_locations = [ "emea-gb-db3-azr" ]

    frequency = 300

    request {        
        url = "https://${random_pet.service.id}.azure-api.net/${azurerm_api_management_api.swapi.path}/people/1"
        http_verb = "GET"

        header {            
            name = "Ocp-Apim-Subscription-Key"
            value = azurerm_api_management_subscription.demosub.primary_key
        }
    }

    validation_rules {
      expected_status_code = 200

    }
}



#### Tests for Defender for APIs ####

# Test Star Wars API with 
# resource "azurerm_application_insights_standard_web_test" "swapi_test_for_defender" {

#     name = "swapi_test"
#     resource_group_name = azurerm_resource_group.rg.name
#     location = azurerm_resource_group.rg.location
#     application_insights_id = azurerm_application_insights.appinsights.id

#     geo_locations = [ "emea-ru-msa-edge" ]

#     frequency = 300

#     request {        
#         url = "http://${azurerm_api_management_api.swapi.service_url}people/1"       
#         http_verb = "GET"

#         header {
#             name = "User-Agent"
#             value = "javascript:"
#         }
#     }

#     validation_rules {
#       expected_status_code = 200

#     }
# }
