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

output "certificate_arn" {
  value       = aws_acm_certificate.cert.arn
  description = "The ARN of the ACM Certificate issued for the domain"
}

output "node_group_arn" {
  value       = aws_eks_node_group.eks_node_group.arn
  description = "The ARN of the EKS node group."
}

output "service_account_arn" {
  value       = aws_iam_role.service_account_role.arn
  description = "The ARN of the service account role."
}
