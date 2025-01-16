# # DNS Validation for ACM Certificate
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.site_cert.domain_validation_options : dvo.domain_name => {
#       name  = dvo.resource_record_name
#       type  = dvo.resource_record_type
#       value = dvo.resource_record_value
#     }
#   }

#   zone_id = aws_route53_zone.main.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   records = [each.value.value]
#   ttl     = 60
# }

# # Route 53 Hosted Zone
# resource "aws_route53_zone" "main" {
#   name = var.domain_name
# }

# # A record for root domain
# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.site_cdn.domain_name
#     zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# # CNAME record for subdomain (optional)
# resource "aws_route53_record" "www" {
#   count   = var.subdomain != "" ? 1 : 0
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "${var.subdomain}.${var.domain_name}"
#   type    = "CNAME"

#   alias {
#     name                   = aws_cloudfront_distribution.site_cdn.domain_name
#     zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# # Output website URL
# output "website_url" {
#   value = "https://${var.domain_name}"
# }