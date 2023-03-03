terraform {
  required_providers {
    azureopenshift = {
      source = "registry.terraform.io/rh-mobb/azureopenshift"
      version = "0.0.15"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azureopenshift" {
}

provider "azurerm" {
  features {}

  skip_provider_registration = "true"
}

resource "azurerm_virtual_network" "aro-vnet" {
  name                = "aro-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/22"]
}

resource "azurerm_subnet" "master-subnet" {
  name                 = "master-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aro-vnet.name
  address_prefixes     = ["10.0.0.0/23"]
  service_endpoints = ["Microsoft.ContainerRegistry"]
  private_link_service_network_policies_enabled = false
}

resource "azurerm_subnet" "worker-subnet" {
  name                 = "worker-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aro-vnet.name
  address_prefixes     = ["10.0.2.0/23"]
  service_endpoints = ["Microsoft.ContainerRegistry"]
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_virtual_network.aro-vnet.id
  role_definition_name = "Network Contributor"
  principal_id = var.resource_provider_id
}

resource "azureopenshift_redhatopenshift_cluster" "test" {
  name                = "tf-openshift"
  location            = var.location
  resource_group_name = var.resource_group_name

  master_profile {
    subnet_id = azurerm_subnet.master-subnet.id
  }

  worker_profile {
    subnet_id = azurerm_subnet.worker-subnet.id
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}