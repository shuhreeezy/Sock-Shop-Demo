# Project-wide variables
variable "project_name" {
  description = "Project name"
  type = string
}

# AWS region
variable "aws_region" {
  description = "AWS region"
  type = string
}

# VPC settings
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)
}

# EKS cluster settings
variable "cluster_name" {
  description = "EKS cluster name"
  type = string
}

variable "eks_node_instance_type" {
  description = "Instance type for EKS nodes"
  type = string
}

variable "desired_capacity" {
  description = "Desired number of EKS worker nodes"
  type = number
}

variable "max_capacity" {
  description = "Maximum number of EKS worker nodes"
  type = number
}

variable "min_capacity" {
  description = "Minimum number of EKS worker nodes"
  type = number
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

# Security group
variable "ingress_cidrs" {
  description = "List of CIDR blocks for ingress rules"
  type = list(string)
  default = ["0.0.0.0/0"]
}

# # Route 53 variables
# variable "domain_name" {
#   description = "Domain name to be managed by Route 53"
#   type        = string
# }

# # Load Balancer values (used in Route 53 DNS record)
# variable "lb_dns_name" {
#   description = "DNS name of the NGINX Ingress Controller LoadBalancer"
#   type        = string
# }

# variable "lb_zone_id" {
#   description = "Zone ID of the LoadBalancer (for Route 53)"
#   type        = string
# }