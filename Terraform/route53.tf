# Route 53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# A Record to point to NGINX LoadBalancer
resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.lb_dns_name  # NGINX Ingress LoadBalancer DNS name
    zone_id                = var.lb_zone_id   # LoadBalancer's hosted zone ID
    evaluate_target_health = false
  }
}
