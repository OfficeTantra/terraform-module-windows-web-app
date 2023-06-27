resource "azurerm_private_endpoint" "windows_web_app" {
  for_each = {
    for key, value in var.windows_web_apps : key => value
    if value.enable_private_endpoint == true && value.cloudflare_protected == false
  }

  name                          = format("pep-%s", each.value.name)
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  subnet_id                     = each.value.virtual_network_subnet_private_endpoint_id
  custom_network_interface_name = format("nic-%s", each.value.name)

  private_service_connection {
    name                           = format("pl-%s", each.value.name)
    private_connection_resource_id = azurerm_windows_web_app.windows_web_app[each.key].id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "privatelink.azurewebsites.net"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

}