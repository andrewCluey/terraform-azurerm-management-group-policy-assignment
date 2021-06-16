locals {
    archetype_file          = "${var.archetype_files_path}/${var.archetype}.json" #"${path.module}/lib/types/${var.archetype}.json"
    policy_assignment_files = var.assignment_file_path #"${path.module}/lib/policyAssignments"
    management_group_scope  = "/providers/Microsoft.Management/managementGroups/${var.management_group}"
    raw_archetype_data      = jsondecode(file(local.archetype_file))
    policies_to_assign      = toset(local.raw_archetype_data.landing_zones.policy_assignments)
}



resource "azurerm_policy_assignment" "assignment" {
    for_each = local.policies_to_assign

    # The policy assignment name length must not exceed '24' characters (FEATURE: Add in a validation step for this)
    name                 = each.key
    scope                = local.management_group_scope
    policy_definition_id = jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.policyDefinitionId
    display_name         = jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.displayName
    location             = try(jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).location, null)
    description          = try(jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.description, "${each.key} Policy Assignment at ${local.management_group_scope}")
    metadata             = <<METADATA
    {
        "category": "General",
        "createdBy": "Terraform",
        "createdOn": "null"
    }
METADATA
    #metadata             = try(jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.metadata, null)
    parameters           = try(jsonencode(jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.parameters), null)
    not_scopes           = jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.notScopes
    enforcement_mode     = jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).properties.enforcementMode
    
    identity {
        type = try(jsondecode(file("${local.policy_assignment_files}/${each.key}.json")).identity.type, "None")
    }
}


