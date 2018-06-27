output "arn" {
  value = "${aws_acm_certificate_validation.default.certificate_arn}"
}
