# Sock-Shop-Demo
This repo was created for the sole purpose of demonstration. 

This project involves the deployment of the Sock Shop application on an EKS (Elastic Kubernetes Service) cluster using Terraform for infrastructure provisioning and Helm for application deployment. The project also sets up a CI/CD pipeline using GitHub Actions to automate deployments, and implements basic monitoring and security using Prometheus, Grafana, and AWS ACM (AWS Certificate Manager) for HTTPS setup.

**Task 1: Deploying the Sock Shop Application on Kubernetes**
*Step 1:* Provisioning Infrastructure with Terraform
The first step was to provision the required Kubernetes infrastructure using Terraform. This included creating an EKS cluster, VPC, subnets, route tables, IAM roles, and security groups.

***Key Terraform Resources:***
VPC, Subnets, Route Tables: Created a custom VPC with subnets and route tables for the EKS cluster to ensure network isolation.
EKS Cluster: Deployed the EKS cluster using the official AWS EKS module, ensuring the cluster was highly available across multiple availability zones.
IAM Roles and Policies: Created IAM roles and policies to grant the necessary permissions for the EKS cluster, nodes, and applications.
Not only are the resources created via Terraform, but I made them dynamic, being able to input values from the tf.vars file. Making the infrastructure dynamic, could be deployed onto multiple different regions. 

*Common Issues:* I ran into issues when provisoning my infra via Terraform. One problem was the Managed Nodes were not joining the cluster. Even when attaching the right policies for NodeRole i.e CNI. The managed node would try to join the cluster for 30mins and then result in NodeCreationFailure. 

*Solution:* Added ECR policy and Commented out route53.tf that was pointing to an ALb that wasnt deployed via nginx helm yet.




*Step 2:*Installing Taefik Ingress Controller via Helm
After provisioning the infrastructure, I installed the Taefik Ingress Controller using Helm to handle incoming traffic and provide Ingress functionality.

The Taefik Ingress Controller is necessary to route external traffic into the Kubernetes cluster. It creates an AWS ELB (Elastic Load Balancer), which is essential for exposing services to the internet.

*Common Issues:* Outdated CRDs (Custom Resource Definitions): I encountered outdated CRDs during deployment, which caused Helm to fail. 

*Solution:* I resolved this by updating the CRDs manually. The requirements.yaml from the microservice-demo has depreciated API. 



*Step 3:* Deploying Sock Shop Application via Helm
I deployed the Sock Shop application using a Helm chart. This microservices-based application is a popular demo for Kubernetes deployments.
I configured the application to use the Taefik Ingress Controller to expose the services. The services include:
    Frontend Service: The main service that users interact with.
    Backend Services: Services for catalog, carts, orders, and users.
The ingress configuration routes traffic through the ELB created by Taefik, allowing the application to be accessible via a custom domain.


*Step 4:* Setting Up HTTPS with AWS ACM
To secure the Sock Shop application, I set up HTTPS using AWS ACM for certificate management and integrated it with the Taefik Ingress Controller.

AWS ACM: I requested a certificate for my domain (babadjanov.com) through ACM. This took some time for DNS validation, but I eventually confirmed ownership through Route 53 DNS records. However, I have commented the ACM resource because validation was taking long. After validation is approved, can specify TLS termination and port 443 for https via Terraform.




**Task 2: Setting Up a CI/CD Pipeline**
*Step 1:* CI/CD Pipeline with GitHub Actions
I created a CI/CD pipeline using GitHub Actions to automate the deployment of the Sock Shop application.

*Common Issues:*
IAM Role Conflicts: During the initial pipeline runs, I encountered IAM role conflicts (roles already existed).

*Solution:* There are several solutions, one was to create a backend via terraform resource, which creates S3 backend and dynamoDB for state locking. Since I am doing this project via local. I took out the terraform.tfstate from .gitignore. I know that it exposes secrets and that is not best practice. For demo purposes; added terraform.tfstate into repo.

*Step 2:* Automating Helm Deployments
The pipeline was configured to deploy the Sock Shop application automatically after infrastructure provisioning was complete.





**Task 3: Basic Monitoring and Security**
*Step 1:* Deploying Prometheus and Grafana
I set up Prometheus for monitoring and Grafana for visualizing metrics using Helm.
Grafana was configured to use Prometheus as a data source. I added custom dashboards to visualize metrics such as CPU usage, memory usage, and pod health. See screenshot with Grafana CPU usage per pod.

*Step 2:* Monitoring Dashboards
Grafana comes with built-in dashboards for Kubernetes and Prometheus metrics. After configuring the data source, I could monitor cluster health, application performance, and other metrics.





**Conclusion**
This project demonstrated the deployment of a Kubernetes-based microservices application, automated via a CI/CD pipeline, and secured with HTTPS and monitoring using Prometheus and Grafana. The combination of Terraform, Helm, and GitHub Actions allowed for scalable and automated deployment, ensuring that the infrastructure and application are maintained consistently across different environments.

To ease automation, can incorporate MAKEFILE!
