variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws-region}"
}

resource "aws_key_pair" "sshpubkey" {
  key_name = "instkey"
  public_key = "${file("${var.keypath}")}"
}
