variable "service_plan_name" {
  description = "The name of the service plan"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}



variable "app_name" {
  description = "The name of the app"
  type        = string

}

variable "site_config" {
  description = "The site config of the app"
  type = list(object({
    always_on  = bool
    ftps_state = string

    application_stack = optional(object({
      current_stack                = optional(string)
      use_custom_runtime           = optional(bool)
      docker_image_name            = optional(string)
      docker_registry_url          = optional(string)
      docker_registry_username     = optional(string)
      docker_registry_password     = optional(string)
      dotnet_version               = optional(string)
      dotnet_core_version          = optional(string)
      tomcat_version               = optional(string)
      java_embedded_server_enabled = optional(bool)
      java_version                 = optional(string)
      node_version                 = optional(string)
      php_version                  = optional(string)
      python                       = optional(bool)
    }))

  }))

}
