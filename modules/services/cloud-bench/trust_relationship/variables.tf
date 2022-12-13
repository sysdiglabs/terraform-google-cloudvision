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

variable "reuse_workload_identity_pool" {
  type        = bool
  description = "Reuse existing workload identity pool"
  default     = false
}