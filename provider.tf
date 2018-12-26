provider "aws" {
  alias  = "cert"
  region = "${var.cert_region}"
}
