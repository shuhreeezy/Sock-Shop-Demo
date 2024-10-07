project_name = "sock-shop"
aws_region   = "us-west-2"

# VPC settings
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones  = ["us-west-2a", "us-west-2b"]

# EKS settings
cluster_name           = "sock-shop-cluster"
eks_node_instance_type = "t3.medium"
node_group_name        = "my-node-group"
desired_capacity       = 1
max_capacity           = 3
min_capacity           = 1
kubernetes_version     = "1.30"

# Route 53 domain settings
domain_name = "babadjanov.com" # Replace with your domain name

<<<<<<< HEAD
certificate_arn = "arn:aws:acm:us-west-2:082154468366:certificate/0ea720e9-c405-4052-9854-a3f4bd0459f7"

# LoadBalancer values (to be updated after the NGINX Ingress is deployed)
lb_dns_name = "aa25595a93130454888042b58d733109-613417734.us-west-2.elb.amazonaws.com" # Replace with the actual LoadBalancer DNS name
lb_zone_id  = "Z1H1FL5HABSF5"                                                          # Replace with the actual LoadBalancer Zone ID
=======
certificate_arn        = "arn:aws:acm:us-west-2:082154468366:certificate/0ea720e9-c405-4052-9854-a3f4bd0459f7"
# LoadBalancer values (to be updated after the NGINX Ingress is deployed)
lb_dns_name            = "a65aa497c7b6648b99bebac1924e665f-400835419.us-west-2.elb.amazonaws.com"  # Replace with the actual LoadBalancer DNS name
lb_zone_id             = "Z1H1FL5HABSF5"  # Replace with the actual LoadBalancer Zone ID
>>>>>>> 1fea3fa16c6c6fce6cfcf98fafdc27fdd27d038d
