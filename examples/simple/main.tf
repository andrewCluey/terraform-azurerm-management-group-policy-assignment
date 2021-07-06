# Deploy the policy assignment module

module "management_group_policy_assignment" {
  source = "../../"
  #source  = "andrewCluey/management-group-policy-assignment/azurerm"
  #version = "0.1.0"

  archetype            = "platform"
  management_group     = "im"
  assignment_file_path = "${path.module}/lib/policyAssignments"
  archetype_files_path = "${path.module}/lib/types"
}

output "m_id" {
  value = module.management_group_policy_assignment.assignment_id
}