resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "this" {
  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  app_settings = {
    BASIC_AUTH_USERNAME = var.basic_auth_username
    BASIC_AUTH_PASSWORD = var.basic_auth_password
  }

  site_config {
    application_stack {
      node_version = "~18"
    }
  }
}

resource "azurerm_function_app_function" "function" {
  name            = var.function_name
  function_app_id = azurerm_windows_function_app.this.id
  language        = "Javascript"

  file {
    name    = "index.js"
    content = file(var.function_file_path)
  }

  test_data = jsonencode({
    name = "Azure"
  })

  config_json = jsonencode({
    bindings : [
      {
        authLevel : "anonymous"
        type : "httpTrigger"
        direction : "in"
        name : "req"
        methods : ["get", "post"]
      },
      {
        type : "http"
        direction : "out"
        name : "res"
      }
    ]
  })
}


