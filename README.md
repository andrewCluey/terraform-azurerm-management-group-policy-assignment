# terraform-azurerm-management-group-policy-assignment
Module to assign Azure policies to Management groups based on a predefined Management group 'Type'.

This module is intended to be used for assigning Azure Policies to Management Groups only.

# USING THE MODULE
This Repository contains associated files that are referenced by the deployment. The intention is that the repo shoudl be forked into your own Repository and then run from there. This allows you to define your own archetype file types and your own Policy Assignment files. 


# OVERVIEW
A defintion file, known as an 'archetype' is used to simplify the application of policies to management groups of a similar 'type'.

For example, an archetype file might be defined that specifies policies for a 'Sanbox' Management Group. This would require very stric policies for the type (& tier) of resources deployed along with stric limitations of how resources interact with other environments. In this case, an archetype woudl be defiend with policies declared to enfiorce these standards. 

The benefit of using these 'types', is that a management group can be assigned to a single group and receive all policies defined. This reduces the amount of duplication needed to assign policies. 

The drawback is that it does reduce flexibility. If a Management Group requires similar, but not the same, set of policies defined in an Archetytpe, then a new archetype will be required. 

This idea was inspired by the Microsoft 'CAF' Terraform modules. Where a whole Enterprise Scale Azure infrastructre can be deployed using Terraform relatively simply. However, we foudn the underlying terraform code to achioeve this to be overly complex, which could introduce problems further down the line shoudl there be a problem. 

So we have taken some of the best bits, and tailored it to our specific needs. 

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