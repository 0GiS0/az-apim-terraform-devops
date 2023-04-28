output "rg" {
  value = azurerm_resource_group.rg.name
}

output "service_name" {
  value = random_pet.service.id
}

output "location" {
  value = var.location
}
