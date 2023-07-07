# Windows App Service module

Creates one or more Windows App Services and returns the Windows App Service attributes for other modules to consume.

See [here](https://raw.githubusercontent.com/heathen1878/terraform-azurerm-windows-web-app/main/terraform.tfvars.example) for an example input.

## Slots

Slots and private endpoints are not compatible therefore if you pass `true` for `enable_private_endpoint` and `deploy_slot` slots will not be deployed.

## Private Endpoints

Private endpoints and IP access restriction do not work properly using Terraform as a private endpoint disables `public access`, so this module will not deploy a privatye endpoint if the `cloudflare_protected` attribute is `true`.

## Virtual Network integration

If the virtual network subnet id contains a resource id then virtual network integration will be configured for the web app.
