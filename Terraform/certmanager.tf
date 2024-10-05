# # ACM Certificate for domain
# resource "aws_acm_certificate" "cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"

#   # Ensure ACM certificate is created before destroying existing one (if any)
#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${var.project_name}-ssl-cert"
#   }
# }

# # Validation record for the certificate using Route 53
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       value  = dvo.resource_record_value
#     }
#   }

#   zone_id = aws_route53_zone.sock_shop_zone.zone_id  # Adjust zone_id to your hosted zone ID variable
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.value]
# # }

# # Certificate validation after DNS records are created
# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
# }
