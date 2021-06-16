# Deploy the policy assignment module

module "management-group-policy-assignment" {
  source  = "andrewCluey/management-group-policy-assignment/azurerm"
  version = "0.1.0"

  archetype        = "platform"
  management_group = "im"
}