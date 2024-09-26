resource "azurerm_virtual_network" "default" {
  name                = "${azurerm_resource_group.default.name}-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_subnet" "default" {
  name                 = "${azurerm_resource_group.default.name}-subnet"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["10.1.0.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.ServiceBus", "Microsoft.CognitiveServices", "Microsoft.AzureCosmosDB"]
}