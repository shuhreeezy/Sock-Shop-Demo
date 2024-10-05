output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

# Outputs for DNS management
output "route53_zone_id" {
  value = aws_route53_zone.sock_shop_zone.zone_id
}

output "lb_dns_name" {
  value = aws_lb.nginx_lb.dns_name
  description = "DNS name of the NGINX LoadBalancer"
}

output "lb_zone_id" {
  value = aws_lb.nginx_lb.zone_id
  description = "Hosted zone ID of the NGINX LoadBalancer"
}

output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
  description = "The ARN of the ACM Certificate issued for the domain"
}