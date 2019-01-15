provider "aws" {
  alias = "acm_account"
}

provider "aws" {
  alias = "route53_account"
}

// Do not remove, this causes input prompts otherwise
// known terraform bug
provider "aws" {}
