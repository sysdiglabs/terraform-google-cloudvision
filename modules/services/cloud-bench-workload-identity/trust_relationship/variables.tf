variable "project_id" {
  type        = string
  description = "ID of project to run the benchmark on"
  default     = ""
}

variable "role_name" {
  type        = string
  description = "The name of the Service Account that will be created."
  default     = "sysdigcloudbench"
}

variable "organization_id" {
  type        = string
  description = "Numeric ID of the organization to be exported to the sink"
}

