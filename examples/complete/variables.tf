variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "cn-shanghai"
}

variable "common_name" {
  description = "Common name prefix for resources"
  type        = string
  default     = "ack-hpa-example"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/8"
}

variable "vswitch1_cidr_block" {
  description = "CIDR block for the first VSwitch"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vswitch2_cidr_block" {
  description = "CIDR block for the second VSwitch"
  type        = string
  default     = "10.0.1.0/24"
}

variable "managed_kubernetes_cluster_name" {
  description = "Name of the ACK managed cluster"
  type        = string
  default     = "ack-hpa-example-cluster"
}

variable "cluster_spec" {
  description = "Specification of the Kubernetes cluster"
  type        = string
  default     = "ack.pro.small"
}

variable "service_cidr" {
  description = "CIDR block for the Kubernetes service network"
  type        = string
  default     = "172.16.0.0/16"
}

variable "system_disk_category" {
  description = "Category of the system disk"
  type        = string
  default     = "cloud_essd"
}

variable "system_disk_size" {
  description = "Size of the system disk in GB"
  type        = number
  default     = 40
}

variable "runtime_name" {
  description = "Container runtime name"
  type        = string
  default     = "containerd"
}

variable "runtime_version" {
  description = "Container runtime version"
  type        = string
  default     = "1.6.28"
}

variable "scaling_config_min_size" {
  description = "Minimum number of nodes in the node pool"
  type        = number
  default     = 2
}

variable "scaling_config_max_size" {
  description = "Maximum number of nodes in the node pool"
  type        = number
  default     = 10
}

variable "sls_project_name" {
  description = "Base name for the SLS project"
  type        = string
  default     = "ack-hpa-example-logs"
}