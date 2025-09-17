output "function_app_id" {
  value = azurerm_windows_function_app.this.id
}

output "invocation_url" {
  value = azurerm_function_app_function.function.invocation_url
}


