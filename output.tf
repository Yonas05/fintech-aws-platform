output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}
output "cloudfront_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.edge.cloudfront.cloudfront_domain_name

}
output "app_url" {
  description = "The URL of the application"
  value       = "https://app.${var.domain_name}"
}

variable "domain_name" {
  description = "The domain name for the application (e.g. example.com)"
  type        = string
}

output "db_endpoint" {
    description = "The endpoint of the RDS database"
    value       = module.rds.db_endpoint
  
}
