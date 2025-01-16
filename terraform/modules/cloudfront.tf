# # CloudFront Distribution
# resource "aws_cloudfront_distribution" "site_cdn" {
#   enabled = true

#   origin {
#     domain_name = aws_s3_bucket_website_configuration.web_config.website_endpoint
#     origin_id   = "S3-${aws_s3_bucket.site_bucket.id}"

#     custom_origin_config {
#       http_port              = 80
#       https_port             = 443
#       origin_protocol_policy = "http-only"
#       origin_ssl_protocols = ["SSLv3", "TLSv1.2"]
#     }
#   }

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "S3-${aws_s3_bucket.site_bucket.id}"

#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#   }

#   viewer_certificate {
#     acm_certificate_arn      = aws_acm_certificate_validation.cert_validation.certificate_arn
#     ssl_support_method        = "sni-only"
#     minimum_protocol_version  = "TLSv1.2_2021"
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   default_root_object = "index.html"
# }
