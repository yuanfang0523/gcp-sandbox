variable "project" {
  type        = string
  description = "GCP Project"
  default     = "picktrace-sandbox"
}

variable "service_name" {
  type        = string
  description = "Name of the service resources belonging to, typically the name of the GIT repo without the -tf postfix."
  default     = "<SERVICE_NAME>"
}

variable "owner" {
  type        = string
  description = "Owner (team or user) of the service"
  default     = "<OWNER>"
}
