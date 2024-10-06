# EKS Security Group for Worker Nodes
resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project_name}-eks-sg"

  # Allow inbound traffic from EKS Control Plane (Port 443 for HTTPS)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to public internet, you can restrict this further
  }

  # Allow inbound traffic from EKS Control Plane (Port 10250 for Kubelet API)
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # You can replace this with your control plane SG if more restrictive
  }

  # Allow outbound traffic from worker nodes to anywhere (internet access)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all outbound traffic
  }

  # Optional: Allow worker nodes to talk to each other
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]  # Allow intra-node communication
  }

  tags = {
    Name = "${var.project_name}-eks-sg"
  }
}

# Security Group for EKS Control Plane (Allow Control Plane to Communicate with Worker Nodes)
resource "aws_security_group" "eks_control_plane_sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project_name}-eks-control-plane-sg"

  # Ingress rule allowing communication from worker nodes on port 443
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = aws_security_group.eks_security_group.id  # Refers to worker node SG
  }

  # Ingress rule allowing communication from worker nodes on port 10250
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    security_groups = aws_security_group.eks_security_group.id  # Refers to worker node SG
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-eks-control-plane-sg"
  }
}
