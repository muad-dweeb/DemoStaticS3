# resource "aws_acm_certificate" "site_cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"

#   subject_alternative_names = [
#     "${var.subdomain}.${var.domain_name}"
#   ]

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.site_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
#   depends_on = [aws_]
# }
