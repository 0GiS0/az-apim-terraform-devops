resource "azapi_resource" "apim_fragment_forward_context"{

    name = "forward-context"
    type = "Microsoft.ApiManagement/service/policyFragments@2021-12-01-preview"

    parent_id = azurerm_api_management.apim.id

    body = jsonencode({
        properties = {
            description = "Forward context to backend"
            format = "xml"
            value = file("./fragments/forward_context.xml")
        }
    })

    lifecycle {
          ignore_changes = [output]
    }

}