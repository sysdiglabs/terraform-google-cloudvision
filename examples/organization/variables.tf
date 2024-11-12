# Mandatory vars
variable "organization_domain" {
  type        = string
  description = "Organization domain. e.g. sysdig.com"
}

# --------------------------
# optionals, with defaults
# --------------------------

variable "max_instances" {
  type        = number
  description = "Max number of instances for the workloads"
  default     = 1
}


#
# scanning
#

variable "deploy_scanning" {
  type        = bool
  description = "true/false whether scanning module is to be deployed"
  default     = false
}

variable "repository_project_ids" {
  default     = []
  type        = list(string)
  description = "Projects were a `gcr`-named topic will be to subscribe to its repository events. If empty, all organization projects will be defaulted."
}


#
# general
#
variable "name" {
  type        = string
  description = "Suffix to be assigned to all created resources. Modify this value in case of conflict / 409 error to bypass Google soft delete issues"
  default     = "sfc"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.name))
    error_message = "ERROR: Invalid name. must contain only lowercase letters (a-z) and numbers (0-9)."
  }
}
