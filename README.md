# terraform-aws-acm-certificate

[![CircleCI](https://circleci.com/gh/azavea/terraform-aws-acm-certificate.svg?style=svg)](https://circleci.com/gh/azavea/terraform-aws-acm-certificate)

A Terraform module to create an Amazon Certificate Manager (ACM) certificate with Route 53 DNS validation.

## Usage

When making use of this module, ensure that either the `AWS_DEFAULT_REGION` or `AWS_REGION` environment variable is set. This helps bypass [validation checks](https://github.com/hashicorp/terraform/issues/21408) that want the `provider` blocks within this module to have a `region` attribute specified.

```hcl
provider "aws" {
  region = "us-east-1"
  alias  = "certificates"
}

provider "aws" {
  region = "us-west-2"
  alias  = "dns"
}

resource "aws_route53_zone" "default" {
  name = "azavea.com"
}

module "cert" {
  source = "github.com/azavea/terraform-aws-acm-certificate"

  providers = {
    aws.acm_account     = "aws.certificates"
    aws.route53_account = "aws.dns"
  }

  domain_name                       = "azavea.com"
  subject_alternative_names         = ["*.azavea.com"]
  hosted_zone_id                    = "${aws_route53_zone.default.zone_id}"
  validation_record_ttl             = "60"
  allow_validation_record_overwrite = true
}
```

## Variables

- `domain_name` - Primary domain name associated with certificate. Also used for the Name tag of the ACM certificate.
- `subject_alternative_names` - Subject alternative domain names.
- `hosted_zone_id` - Route 53 hosted zone ID for `domain_name`.
- `validation_record_ttl` - Route 53 record time-to-live (TTL) for validation record (default: `60`).
- `allow_validation_record_overwrite` - Allow Route 53 record creation to overwrite existing records (default: `true`).
- `tags` - A map of extra tags that is associated with the ACM Certificate.

## Outputs

- `arn` - The Amazon Resource Name (ARN) of the ACM certificate
