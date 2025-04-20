resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.service_plan_sku
  os_type             = var.service_plan_os_type
}

resource "azurerm_windows_web_app" "this" {
  name                = var.app_name
  resource_group_name = azurerm_service_plan.this.resource_group_name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id

  dynamic "site_config" {
    for_each = var.site_config != null ? var.site_config : []

    content {
      always_on  = site_config.value.always_on
      ftps_state = site_config.value.ftps_state

      dynamic "application_stack" {
        for_each = site_config.value.application_stack != null ? [site_config.value.application_stack] : []
        content {
          current_stack                = application_stack.value.current_stack
          docker_image_name            = application_stack.value.docker_image_name
          docker_registry_url          = application_stack.value.docker_registry_url
          docker_registry_username     = application_stack.value.docker_registry_username
          docker_registry_password     = application_stack.value.docker_registry_password
          dotnet_version               = application_stack.value.dotnet_version
          dotnet_core_version          = application_stack.value.dotnet_core_version
          tomcat_version               = application_stack.value.tomcat_version
          java_embedded_server_enabled = application_stack.value.java_embedded_server_enabled
          java_version                 = application_stack.value.java_version
          node_version                 = application_stack.value.node_version
          php_version                  = application_stack.value.php_version
          python                       = application_stack.value.python
        }
      }

    }
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

}
