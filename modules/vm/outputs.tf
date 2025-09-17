output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "ssh_access_enabled" {
  value = [
    for rule in azurerm_network_security_group.nsg.security_rule : rule.name
    if rule.destination_port_range == "22" && rule.access == "Allow"
  ]
}


