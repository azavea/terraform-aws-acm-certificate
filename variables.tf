variable "domain_name" {
  type        = string
  description = "Primary certificate domain name"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "Subject alternative domain names"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route 53 Zone ID for DNS validation records"
}

variable "validation_record_ttl" {
  default     = "60"
  description = "Route 53 time-to-live for validation records"
}

variable "allow_validation_record_overwrite" {
  default     = "true"
  description = "Allow Route 53 record creation to overwrite existing records"
}

variable "tags" {
  default     = {}
  description = "Extra tags to attach to the ACM certificate"
}

