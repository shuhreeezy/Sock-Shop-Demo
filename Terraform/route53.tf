# Route 53 Hosted Zone
resource "aws_route53_zone" "sock_shop_zone" {
  name = var.domain_name
}

<<<<<<< HEAD
<<<<<<< HEAD
# # A Record to point to the NGINX LoadBalancer (ALB)
# resource "aws_route53_record" "app_record" {
#   zone_id = aws_route53_zone.sock_shop_zone.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = var.lb_dns_name  # NGINX LoadBalancer DNS name
#     zone_id                = var.lb_zone_id   # LoadBalancer's hosted zone ID
#     evaluate_target_health = false
#   }
# }
=======
# A Record to point to the NGINX LoadBalancer (ALB)
=======
 # A Record to point to the NGINX LoadBalancer (ALB)
>>>>>>> b25eba9a0ec6a0f6127e02a07bf6f9b4e1db5872
resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.sock_shop_zone.zone_id
  name    = var.domain_name
  type    = "A"
  
  alias {
    name                   = var.lb_dns_name  # NGINX LoadBalancer DNS name
    zone_id                = var.lb_zone_id   # LoadBalancer's hosted zone ID
    evaluate_target_health = false
  }
}
>>>>>>> 295915b18a61e598f1d1bebee537294df6e2b455
