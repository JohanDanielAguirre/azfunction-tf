provider "azurerm" {
  features {}
}

module "rg" {
  source   = "./modules/resource_group"
  name     = var.name_function
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.rg.name
  location            = module.rg.location
  vnet_name           = "vnet-linux"
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "subnet-linux"
  subnet_prefixes     = ["10.0.1.0/24"]
}

module "function_app" {
  source              = "./modules/function_app"
  resource_group_name = module.rg.name
  location            = module.rg.location
  sa_name             = var.name_function
  service_plan_name   = var.name_function
  function_app_name   = var.name_function
  function_name       = var.name_function
  function_file_path  = "example/index.js"
  basic_auth_username = var.basic_auth_username
  basic_auth_password = var.basic_auth_password
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = module.rg.name
  location            = module.rg.location
  subnet_id           = module.network.subnet_id
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}