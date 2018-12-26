resource "aws_acm_certificate" "default" {
  domain_name               = "${var.domain_name}"
  subject_alternative_names = ["${var.subject_alternative_names}"]
  validation_method         = "DNS"
  provider                  = "aws.cert"

  tags {
    Name      = "${var.domain_name}"
    terraform = "true"
  }
}

resource "aws_route53_record" "validation" {
  count = "${length(var.subject_alternative_names) + 1}"

  name    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${var.hosted_zone_id}"
  records = ["${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = "${var.validation_record_ttl}"
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.default.arn}"
  provider        = "aws.cert"

  validation_record_fqdns = [
    "${aws_route53_record.validation.*.fqdn}",
  ]
}
