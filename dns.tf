data "aws_route53_zone" "selected" {
  name    = "${var.domainname}"
}

resource "aws_route53_record" "fb8747" {
  count   = "1"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "front.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.front.public_ip}"]
}

output "route53-out" {
  value = ["${aws_route53_record.fb8747.name}"]
  description = "DNS name"
}
