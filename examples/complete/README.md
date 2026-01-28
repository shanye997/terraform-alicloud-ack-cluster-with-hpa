# Complete Example

This example demonstrates how to use the ACK HPA Terraform module to create a complete ACK cluster with horizontal pod autoscaler capabilities.

## Usage

To run this example:

1. Set up your Alibaba Cloud credentials
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Review the plan:
   ```bash
   terraform plan
   ```
4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Configuration

This example creates:

- A VPC with two VSwitches in different availability zones
- An ACK professional managed cluster
- A node pool with auto-scaling enabled (2-10 nodes)
- Security groups with HTTP/HTTPS access
- SLS project for logging
- ROS stack for deploying Kubernetes resources
- Required RAM roles and policies

## Variables

You can customize the deployment by setting variables in a `terraform.tfvars` file:

```hcl
region                              = "cn-shanghai"
common_name                         = "my-ack-hpa"
managed_kubernetes_cluster_name     = "my-cluster"
vpc_cidr_block                      = "192.168.0.0/16"
vswitch1_cidr_block                 = "192.168.1.0/24"
vswitch2_cidr_block                 = "192.168.2.0/24"
scaling_config_min_size             = 1
scaling_config_max_size             = 5
```

## Cleanup

To destroy the resources:

```bash
terraform destroy
```

**Note:** Make sure to delete any applications deployed to the cluster before destroying the infrastructure.