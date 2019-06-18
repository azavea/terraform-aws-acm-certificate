resource "aws_acm_certificate" "default" {
  provider                  = aws.acm_account
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags = merge(
    {
      "Name" = var.domain_name
    },
    var.tags,
  )
}

resource "aws_route53_record" "validation" {
  provider = aws.route53_account
  count    = length(var.subject_alternative_names) + 1

  name    = aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_name"]
  type    = aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_type"]
  zone_id = var.hosted_zone_id
  records         = [aws_acm_certificate.default.domain_validation_options[count.index]["resource_record_value"]]
  ttl             = var.validation_record_ttl
  allow_overwrite = var.allow_validation_record_overwrite
}

resource "aws_acm_certificate_validation" "default" {
  provider        = aws.acm_account
  certificate_arn = aws_acm_certificate.default.arn

  validation_record_fqdns = aws_route53_record.validation.*.fqdn
}

