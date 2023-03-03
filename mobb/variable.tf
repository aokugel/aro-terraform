variable "resource_group_name" {
  # default = ""
}
variable "location" {
  default = "eastus"
}
# variable "master_subnet_id" {
#   default = "/subscriptions/ede7f891-835c-4128-af5b-0e53848e54e7/resourceGroups/openenv-9vm4c/providers/Microsoft.Network/virtualNetworks/aro-vnet/subnets/master-subnet"
# }
# variable "worker_subnet_id" {
#   default = "/subscriptions/ede7f891-835c-4128-af5b-0e53848e54e7/resourceGroups/openenv-9vm4c/providers/Microsoft.Network/virtualNetworks/aro-vnet/subnets/worker-subnet"
# }
variable "client_id" {
  # default = ""
}
variable "client_secret" {
  # default = ""
}
  
variable "resource_provider_id" {
  # default = ""
}