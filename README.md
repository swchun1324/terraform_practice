# Terraform for set up the Kubernetes Ec2 instance

Automatic deployment and management of EC2 instances using Terraform.

<hr/>


## Implementation details

This terraform resource platform builds:
* Compute
    * EC2 instance
  * Network
    * Virtual Private Cloud
    * Internet Gateway
    * Security Group
    * Route table
    * Subnet
  * RDS
  * Load balancer
     * Target group
     * Listener port
  * Kubernetes node(EC2 instance) connected to the RDS using the rancher.
    
<hr/>

## Important Configuration for use


| File Name  | Reasons |
| ------------- | ------------- |
| Locals. tf  | Can change the Security group ingress and egress options for the public/private EC2 instance, Currently it allows all ports for the EC2 public instance  |
| main.tf  | Can change the alb module target port(default 8000), listener port(80)   |
| main.tf  | Must specify the key name, public, or private key so that the user data can work.   |
