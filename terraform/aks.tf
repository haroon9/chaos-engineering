data "azurerm_kubernetes_service_versions" "current" {
  location        = azurerm_resource_group.default.location
  include_preview = false
  version_prefix  = "1.29"
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${azurerm_resource_group.default.name}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${azurerm_resource_group.default.name}-k8s"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  sku_tier            = "Standard"

  node_resource_group = "${azurerm_resource_group.default.name}-nrg"

  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = "rotation"
    min_count                   = 2
    max_count                   = 50
    enable_auto_scaling         = true
    vm_size                     = var.vm_size
    os_disk_size_gb             = 30
    zones                       = [1, 2, 3]
    type                        = "VirtualMachineScaleSets"
    vnet_subnet_id              = azurerm_subnet.default.id

    tags = {
      environment = var.environment
    }
  }
  lifecycle {
    ignore_changes  = [default_node_pool]
    prevent_destroy = true
  }
  storage_profile {
    blob_driver_enabled = true
  }

  role_based_access_control_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_role_assignment" "subnet_role" {
  scope                = azurerm_subnet.default.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.identity[0].principal_id
}