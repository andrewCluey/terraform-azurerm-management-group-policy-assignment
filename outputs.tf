output "id" {
    value = azurerm_policy_assignment[each.key].assignment.id
    description = "The ID of the new policy assignment"
}