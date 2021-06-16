variable "archetype" {
  type        = string
  description = "The archetype assigned to the Management Group. Only archetype definitions defined in this repo (./types/) can be used."
}

variable "management_group" {
  type        = string
  description = "The Management Group where policies are to be assigned."
}


variable "assignment_file_path" {
  type        = string
  description = "The path to the Policy Assignment files."
}

variable "archetype_files_path" {
  type        = string
  description = "description"
}