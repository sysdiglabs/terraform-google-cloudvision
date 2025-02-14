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
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "sfc"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.name))
    error_message = "ERROR: Invalid name. must contain only lowercase letters (a-z) and numbers (0-9)."
  }
}
