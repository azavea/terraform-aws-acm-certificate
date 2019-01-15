variable "domain_name" {
  type        = "string"
  description = "primary certificate domain name"
}

variable "subject_alternative_names" {
  type    = "list"
  default = []
}

variable "hosted_zone_id" {
  type        = "string"
  description = "Route53 Zone ID where DNS validation records will be created"
}

variable "validation_record_ttl" {
  default = "60"
}

variable "acm_certificate_tags" {
  description = "map of tags to attach to the ACM certificate"
  default     = {}
}
