variable "domain_name" {}

variable "subject_alternative_names" {
  type = "list"
}

variable "hosted_zone_id" {}

variable "validation_record_ttl" {
  default = "60"
}
