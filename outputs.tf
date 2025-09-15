output "url" {
  value       = azurerm_function_app_function.faf.invocation_url
  sensitive   = false
  description = "description"
}
output "vm_public_ip" {
  description = "Public IP of the Linux VM"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

output "ssh_access_enabled" {
  description = "Indica si el puerto 22 está permitido en el NSG"
  value = [
    for rule in azurerm_network_security_group.nsg.security_rule : rule.name
    if rule.destination_port_range == "22" && rule.access == "Allow"
  ]
}