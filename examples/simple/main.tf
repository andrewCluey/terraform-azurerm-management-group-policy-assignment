# Deploy the policy assignment module
module "assign_policies" {
  source   = "../../"

  archetype        = "platform"
  management_group = "im"
}