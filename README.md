# terraform-azurerm-management-group-policy-assignment
Module to assign Azure policies to Management groups based on a predefined Management group 'Type'.

This module is intended to be used for assigning Azure Policies to Management Groups only.

# USING THE MODULE
This


# OVERVIEW
A defintion file, known as an 'archetype' is used to simplify the application of policies to management groups of a similar 'type'.

For example, an archetype file might be defined that specifies policies for a 'Sandbox' Management Group. This would require very stric policies for the type (& tier) of resources deployed along with strict limitations of how resources interact with other environments. In this case, an archetype would be defined with policies declared to enforce these standards. 

The benefit of using these 'types', is that a management group can be assigned to a single archetype type and receive all policies defined. This reduces the amount of duplication needed to assign policies. 

However, this may reduce flexibility. If a Management Group requires similar, but not the same, set of policies defined in an Archetytpe, then a new archetype will be required. 

Tghe use of Archetypes, and the method for defining them in code as part of the Terraform deployment, is define din the Microsoft 'CAF' Terraform modules. Where an Enterprise Scale Azure infrastructure can be deployed using Terraform. While the Microsoft CAF module achieves the deployment of a large, Enterprise Scale Azure environment, I found the code itself to be quite complex and in many cases, not required for smaller environments.


# DEEP DIVE

```
locals {
    archetype_file = "./types/${var.archetype}.json"
    policy_assignment_files = "./policyAssignments"
    # read archetype file
    management_group_scope = "/providers/Microsoft.Management/managementGroups/${var.management_group}"
    raw_archetype_data     = jsondecode(file(local.archetype_file))
    policies_to_assign     = toset(local.raw_archetype_data.landing_zones.policy_assignments)
    definition_path        = "/providers/Microsoft.Management/managementgroups/${var.root-management_group}/"
}
```