terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      version               = ">= 3.0.0"
      configuration_aliases = [aws.acm_account, aws.route53_account]
    }
  }
}
