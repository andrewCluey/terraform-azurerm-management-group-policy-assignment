# Deploy the policy assignment module

module "management_group_policy_assignment" {
  source = "../../"
  #source  = "andrewCluey/management-group-policy-assignment/azurerm"
  #version = "0.1.0"

  archetype        = "platform"
  management_group = "im"
}

output "m_id" {
  value = module.management_group_policy_assignment.assignment_id
}