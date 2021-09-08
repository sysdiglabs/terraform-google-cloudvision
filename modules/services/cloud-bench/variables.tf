variable "regions" {
  type        = list(string)
  description = "List of regions in which to run the benchmark. If empty, the task will contain all regions by default."
  default     = []
}

variable "project_id" {
  type = string
  description = "ID of project to run the benchmark on"
  default = ""
}