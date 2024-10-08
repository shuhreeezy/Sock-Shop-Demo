# EKS Cluster
# Create the EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }

  depends_on = [
    aws_internet_gateway.igw,
  ]
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public_subnet[*].id
  instance_types  = [var.eks_node_instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  enable_bootstrap_user_data = true
  
  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role.eks_node_role,
  ]
}

# IAM policy document for EKS Cluster role (EKS service)
data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    effect = "Allow"
  }
}

# IAM role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.project_name}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json

  tags = {
    Name = "${var.project_name}-eks-cluster-role"
  }
}

# IAM role policy attachment for EKS Cluster
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# IAM policy document for EKS Node role (EC2 service)
data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

# IAM role for EKS Node group
resource "aws_iam_role" "eks_node_role" {
  name               = "${var.project_name}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json

  tags = {
    Name = "${var.project_name}-eks-node-role"
  }
}

# IAM role policy attachment for EKS Node group
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach CNI policy to Node group
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attach AmazonEKSVPCResourceController Policy to the EKS Cluster Role
resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}


# IAM policy document for the service account role
data "aws_iam_policy_document" "service_account_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.${var.aws_region}.amazonaws.com/id/${aws_eks_cluster.eks_cluster.id}"]
    }

    effect = "Allow"
  }
}

# IAM role for the service account
resource "aws_iam_role" "service_account_role" {
  name               = "${var.project_name}-service-account-role"
  assume_role_policy = data.aws_iam_policy_document.service_account_assume_role_policy.json

  tags = {
    Name = "${var.project_name}-service-account-role"
  }
}

# Service Account in Kubernetes
resource "kubernetes_service_account" "my_service_account" {
  metadata {
    name      = "my-service-account"
    namespace = "default" # Specify the desired namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.service_account_role.arn
    }
  }
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name # Ensure this matches your EKS cluster resource name
}
