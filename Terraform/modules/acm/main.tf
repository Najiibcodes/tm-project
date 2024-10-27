resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name  # Primary domain for the certificate
  validation_method = "DNS"

  tags = {
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "certificate_arn" {
  value = aws_acm_certificate.certificate.arn
}

output "domain_validation_options" {
  value = aws_acm_certificate.certificate.domain_validation_options
}
