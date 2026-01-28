output "cluster_id" {
  description = "The ID of the ACK managed Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.ack.id
}

output "cluster_name" {
  description = "The name of the ACK managed Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.ack.name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.vpc.cidr_block
}

output "vswitch_ids" {
  description = "The IDs of all VSwitches"
  value       = [for vswitch in alicloud_vswitch.vswitches : vswitch.id]
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.sg.id
}

output "sls_project_name" {
  description = "The name of the SLS project"
  value       = alicloud_log_project.sls_project.project_name
}

output "node_pool_id" {
  description = "The ID of the node pool"
  value       = alicloud_cs_kubernetes_node_pool.node_pool.id
}

output "scaling_group_id" {
  description = "The ID of the scaling group for the node pool"
  value       = alicloud_cs_kubernetes_node_pool.node_pool.scaling_group_id
}

output "ros_stack_id" {
  description = "The ID of the ROS stack"
  value       = alicloud_ros_stack.deploy_k8s_resource.id
}

output "ros_stack_status" {
  description = "The status of the ROS stack"
  value       = alicloud_ros_stack.deploy_k8s_resource.status
}

output "cluster_connections" {
  description = "Connection information for the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.ack.connections
  sensitive   = true
}

output "nat_gateway_id" {
  description = "The ID of the NAT gateway"
  value       = alicloud_cs_managed_kubernetes.ack.nat_gateway_id
}

output "slb_id" {
  description = "The ID of the API Server load balancer"
  value       = alicloud_cs_managed_kubernetes.ack.slb_id
}

output "worker_ram_role_name" {
  description = "The RAM role name attached to worker nodes"
  value       = alicloud_cs_managed_kubernetes.ack.worker_ram_role_name
}