# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version = var.kubernetes_version

  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }

  depends_on = [
    aws_internet_gateway.igw,
  ]
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids = aws_subnet.public_subnet[*].id
  instance_types = [var.eks_node_instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    max_size = var.max_capacity
    min_size = var.min_capacity
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role.eks_node_role,
  ]
}
