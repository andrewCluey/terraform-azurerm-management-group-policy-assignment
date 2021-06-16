output "assignment_id" {
  value = tomap({
    for k, pa in azurerm_policy_assignment.assignment : k => pa.id
  })
}
