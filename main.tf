resource "aws_acm_certificate" "default" {
  provider                  = aws.acm_account
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      Name = var.domain_name
    },
    var.tags,
  )
}

resource "aws_route53_record" "validation" {
  provider = aws.route53_account
  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name            = each.value.name
  type            = each.value.type
  zone_id         = var.hosted_zone_id
  records         = [each.value.record]
  ttl             = var.validation_record_ttl
  allow_overwrite = var.allow_validation_record_overwrite
}

resource "aws_acm_certificate_validation" "default" {
  provider        = aws.acm_account
  certificate_arn = aws_acm_certificate.default.arn

  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
