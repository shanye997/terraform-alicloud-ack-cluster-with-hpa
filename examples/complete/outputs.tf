output "cluster_id" {
  description = "The ID of the ACK managed Kubernetes cluster"
  value       = module.ack_hpa_cluster.cluster_id
}

output "cluster_name" {
  description = "The name of the ACK managed Kubernetes cluster"
  value       = module.ack_hpa_cluster.cluster_name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.ack_hpa_cluster.vpc_id
}

output "node_pool_id" {
  description = "The ID of the node pool"
  value       = module.ack_hpa_cluster.node_pool_id
}

output "sls_project_name" {
  description = "The name of the SLS project"
  value       = module.ack_hpa_cluster.sls_project_name
}

output "ros_stack_id" {
  description = "The ID of the ROS stack"
  value       = module.ack_hpa_cluster.ros_stack_id
}