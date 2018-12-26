variable "domain_name" {}

variable "subject_alternative_names" {
  type = "list"
}

variable "hosted_zone_id" {}

variable "validation_record_ttl" {
  default = "60"
}

variable "cert_region" {
  description = "region to keep your certificate. Use us-east-1 for CloudFront"
  default     = "us-east-1"
}
