# Hosted Zone for najiib.co.uk
resource "aws_route53_zone" "najiib" {
  name = var.domain_name
}

# A Record for www.najiib.co.uk
resource "aws_route53_record" "www_najiib" {
  zone_id = aws_route53_zone.najiib.zone_id
  name    = var.subdomain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name  # Pass ALB DNS name as a variable
    zone_id                = var.alb_zone_id   # Pass ALB zone ID as a variable
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in var.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      value   = dvo.resource_record_value
      zone_id = var.zone_id
    }
  }

  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.value]
  zone_id = each.value.zone_id
}
