# Project name
project_name = "sock-shop"

# AWS Account ID
account_id = "082154468366" # Replace with your actual AWS account ID

# AWS Region
aws_region = "us-west-2"

# VPC settings
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["us-west-2a", "us-west-2b"]

# EKS settings
cluster_name           = "sock-shop-cluster"
eks_node_instance_type = "t3.medium"
node_group_name        = "my-node-group"
desired_capacity       = 3
max_capacity           = 3
min_capacity           = 1
kubernetes_version     = "1.30"

# Route 53 domain settings
domain_name = "babadjanov.com" # Replace with your domain name

# LoadBalancer values (to be updated after the NGINX Ingress is deployed)
lb_dns_name = "a3d58aa18219247539d2aa3d35f63117-1928582279.us-west-2.elb.amazonaws.com" # Replace with the actual LoadBalancer DNS name
lb_zone_id  = "Z1H1FL5HABSF5"                                                          # Replace with the actual LoadBalancer Zone ID
