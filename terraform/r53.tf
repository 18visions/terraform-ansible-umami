resource "aws_route53_record" "ghost-web-001" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.subdomain}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.umami-web-prod.public_ip]
}