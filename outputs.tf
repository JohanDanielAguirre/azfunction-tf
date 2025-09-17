output "url" {
  value       = module.function_app.invocation_url
  sensitive   = false
  description = "URL de invocación de la Function"
}
output "vm_public_ip" {
  description = "Public IP of the Linux VM"
  value       = module.vm.public_ip
}

output "ssh_access_enabled" {
  description = "Indica si el puerto 22 está permitido en el NSG"
  value       = module.vm.ssh_access_enabled
}