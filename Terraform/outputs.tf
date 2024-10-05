output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
