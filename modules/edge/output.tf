output "alb_cert_arn"      { value = aws_acm_certificate_validation.alb.certificate_arn }
output "cloudfront_domain" { value = aws_cloudfront_distribution.this.domain_name }
