terraform {

  backend "azurerm" {
    resource_group_name  = "Terraform-States"
    storage_account_name = "statestf"
    container_name       = "apim"
    key                  = "apim.terraform.tfstate"
  }
}