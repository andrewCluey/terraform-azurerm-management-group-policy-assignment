variable "archetype" {
  type        = string
  description = "The archetype assigned to the Management Group. Only archetype definitions defined in this repo (./types/) can be used."
}

variable "management_group" {
  type        = string
  description = "The Management Group where policies are to be assigned."
}
