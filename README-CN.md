# 阿里云 ACK 集群弹性伸缩 Terraform 模块

terraform-alicloud-ack-cluster-with-hpa

======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ack-cluster-with-hpa/blob/main/README.md) | 简体中文

本 Terraform 模块用于创建具备水平 Pod 自动缩放器（HPA）功能的完整 ACK（阿里云容器服务 Kubernetes 版）集群。该模块实现了[容器化应用的弹性伸缩攻略](https://www.aliyun.com/solution/tech-solution/ack-hpa)解决方案。

模块创建和配置以下资源：
- 多可用区的 VPC 和交换机
- 带有 HTTP/HTTPS 访问规则的安全组
- 专业版规格的 ACK 托管 Kubernetes 集群
- 具备自动缩放功能的节点池
- 用于日志记录的 SLS（简单日志服务）项目
- 用于部署 Kubernetes 资源的 ROS 栈
- 集群运行所需的 RAM 角色和策略

## 使用方法

```hcl
provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

module "ack_hpa_cluster" {
  source = "alibabacloud-automation/ack-cluster-with-hpa/alicloud"
  
  # 基础配置
  availability_zones = [data.alicloud_zones.default.zones.0.id, data.alicloud_zones.default.zones.1.id]
  
  # VPC 配置
  vpc_cidr_block        = "10.0.0.0/8"
  vpc_name              = "ack-hpa-vpc"
  vswitch1_cidr_block   = "10.0.0.0/24"
  vswitch2_cidr_block   = "10.0.1.0/24"
  
  # 集群配置
  managed_kubernetes_cluster_name = "my-ack-hpa-cluster"
  cluster_spec                    = "ack.pro.small"
  service_cidr                    = "172.16.0.0/16"
  
  # 节点池配置
  node_pool_name          = "default-nodepool"
  instance_types          = ["ecs.g7.large"]
  system_disk_category    = "cloud_essd"
  system_disk_size        = 40
  scaling_config_min_size = 2
  scaling_config_max_size = 10
  
  # SLS 配置
  sls_project_name = "my-ack-hpa-logs"
  
  # ROS 栈配置
  ros_stack_name = "ack-hpa-k8s-resources"
  ros_parameters = [
    {
      parameter_key   = "cluster_id"
      parameter_value = module.ack_hpa_cluster.cluster_id
    },
    {
      parameter_key   = "sls_project_name"
      parameter_value = module.ack_hpa_cluster.sls_project_name
    }
  ]
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ack-cluster-with-hpa/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cs_kubernetes_node_pool.node_pool](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.ack](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes) | resource |
| [alicloud_log_project.sls_project](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ros_stack.deploy_k8s_resource](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ros_stack) | resource |
| [alicloud_security_group.sg](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.ingress_http](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.ingress_https](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.vswitch2](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_ram_roles.roles](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones for the VPC resources | `list(string)` | n/a | yes |
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | List of cluster addons to install | <pre>list(object({<br>    name     = string<br>    config   = string<br>    version  = string<br>    disabled = bool<br>  }))</pre> | <pre>[<br>  {<br>    "config": "",<br>    "disabled": false,<br>    "name": "ack-node-local-dns",<br>    "version": ""<br>  },<br>  {<br>    "config": "{\"IPVlan\":\"false\",\"NetworkPolicy\":\"false\",\"ENITrunking\":\"false\"}",<br>    "disabled": false,<br>    "name": "terway-eniip",<br>    "version": ""<br>  },<br>  {<br>    "config": "",<br>    "disabled": false,<br>    "name": "csi-plugin",<br>    "version": ""<br>  },<br>  {<br>    "config": "",<br>    "disabled": false,<br>    "name": "csi-provisioner",<br>    "version": ""<br>  },<br>  {<br>    "config": "{\"CnfsOssEnable\":\"false\",\"CnfsNasEnable\":\"false\"}",<br>    "disabled": false,<br>    "name": "storage-operator",<br>    "version": ""<br>  },<br>  {<br>    "config": "",<br>    "disabled": true,<br>    "name": "nginx-ingress-controller",<br>    "version": ""<br>  },<br>  {<br>    "config": "{\"IngressDashboardEnabled\":\"true\"}",<br>    "disabled": false,<br>    "name": "logtail-ds",<br>    "version": ""<br>  },<br>  {<br>    "config": "",<br>    "disabled": false,<br>    "name": "alb-ingress-controller",<br>    "version": ""<br>  },<br>  {<br>    "config": "",<br>    "disabled": false,<br>    "name": "ack-helm-manager",<br>    "version": ""<br>  },<br>  {<br>    "config": "",<br>    "disabled": false,<br>    "name": "arms-prometheus",<br>    "version": ""<br>  }<br>]</pre> | no |
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | Specification of the Kubernetes cluster | `string` | `"ack.pro.small"` | no |
| <a name="input_delete_options"></a> [delete\_options](#input\_delete\_options) | List of delete options for cluster resources | <pre>list(object({<br>    delete_mode   = string<br>    resource_type = string<br>  }))</pre> | <pre>[<br>  {<br>    "delete_mode": "delete",<br>    "resource_type": "ALB"<br>  },<br>  {<br>    "delete_mode": "delete",<br>    "resource_type": "SLB"<br>  },<br>  {<br>    "delete_mode": "delete",<br>    "resource_type": "SLS_Data"<br>  },<br>  {<br>    "delete_mode": "delete",<br>    "resource_type": "SLS_ControlPlane"<br>  },<br>  {<br>    "delete_mode": "delete",<br>    "resource_type": "PrivateZone"<br>  }<br>]</pre> | no |
| <a name="input_http_rule_cidr_ip"></a> [http\_rule\_cidr\_ip](#input\_http\_rule\_cidr\_ip) | CIDR IP for the HTTP security group rule | `string` | `"0.0.0.0/0"` | no |
| <a name="input_http_rule_ip_protocol"></a> [http\_rule\_ip\_protocol](#input\_http\_rule\_ip\_protocol) | IP protocol for the HTTP security group rule | `string` | `"tcp"` | no |
| <a name="input_http_rule_port_range"></a> [http\_rule\_port\_range](#input\_http\_rule\_port\_range) | Port range for the HTTP security group rule | `string` | `"80/80"` | no |
| <a name="input_http_rule_type"></a> [http\_rule\_type](#input\_http\_rule\_type) | Type of the HTTP security group rule | `string` | `"ingress"` | no |
| <a name="input_https_rule_cidr_ip"></a> [https\_rule\_cidr\_ip](#input\_https\_rule\_cidr\_ip) | CIDR IP for the HTTPS security group rule | `string` | `"0.0.0.0/0"` | no |
| <a name="input_https_rule_ip_protocol"></a> [https\_rule\_ip\_protocol](#input\_https\_rule\_ip\_protocol) | IP protocol for the HTTPS security group rule | `string` | `"tcp"` | no |
| <a name="input_https_rule_port_range"></a> [https\_rule\_port\_range](#input\_https\_rule\_port\_range) | Port range for the HTTPS security group rule | `string` | `"443/443"` | no |
| <a name="input_https_rule_type"></a> [https\_rule\_type](#input\_https\_rule\_type) | Type of the HTTPS security group rule | `string` | `"ingress"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of ECS instance types for the node pool | `list(string)` | <pre>[<br>  "ecs.g7.large"<br>]</pre> | no |
| <a name="input_managed_kubernetes_cluster_name"></a> [managed\_kubernetes\_cluster\_name](#input\_managed\_kubernetes\_cluster\_name) | Name of the ACK managed cluster | `string` | `"ack-hpa-cluster"` | no |
| <a name="input_new_nat_gateway"></a> [new\_nat\_gateway](#input\_new\_nat\_gateway) | Whether to create a new NAT gateway | `bool` | `true` | no |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | Name of the node pool | `string` | `"ack-hpa-nodepool"` | no |
| <a name="input_ram_policy_type"></a> [ram\_policy\_type](#input\_ram\_policy\_type) | Type of the RAM policy | `string` | `"System"` | no |
| <a name="input_ram_role_force"></a> [ram\_role\_force](#input\_ram\_role\_force) | Whether to force delete RAM roles | `bool` | `true` | no |
| <a name="input_ros_disable_rollback"></a> [ros\_disable\_rollback](#input\_ros\_disable\_rollback) | Whether to disable rollback on ROS stack creation failure | `bool` | `true` | no |
| <a name="input_ros_parameters"></a> [ros\_parameters](#input\_ros\_parameters) | Parameters for the ROS stack | <pre>list(object({<br>    parameter_key   = string<br>    parameter_value = string<br>  }))</pre> | `[]` | no |
| <a name="input_ros_stack_name"></a> [ros\_stack\_name](#input\_ros\_stack\_name) | Name of the ROS stack for deploying Kubernetes resources | `string` | n/a | yes |
| <a name="input_ros_template_url"></a> [ros\_template\_url](#input\_ros\_template\_url) | URL of the ROS template for deploying Kubernetes resources | `string` | `"https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/ros-templates/documents/solution/micro/elastic-scaling-container-through-hpa-k8s-resource.tf.yaml"` | no |
| <a name="input_runtime_name"></a> [runtime\_name](#input\_runtime\_name) | Container runtime name | `string` | `"containerd"` | no |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | Container runtime version | `string` | `"1.6.28"` | no |
| <a name="input_scaling_config_enable"></a> [scaling\_config\_enable](#input\_scaling\_config\_enable) | Whether to enable auto scaling for the node pool | `bool` | `true` | no |
| <a name="input_scaling_config_max_size"></a> [scaling\_config\_max\_size](#input\_scaling\_config\_max\_size) | Maximum number of nodes in the node pool | `number` | `10` | no |
| <a name="input_scaling_config_min_size"></a> [scaling\_config\_min\_size](#input\_scaling\_config\_min\_size) | Minimum number of nodes in the node pool | `number` | `2` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group | `string` | `"ack-hpa-sg"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR block for the Kubernetes service network | `string` | `"172.16.0.0/16"` | no |
| <a name="input_slb_internet_enabled"></a> [slb\_internet\_enabled](#input\_slb\_internet\_enabled) | Whether to enable internet SLB for the cluster | `bool` | `true` | no |
| <a name="input_sls_project_name"></a> [sls\_project\_name](#input\_sls\_project\_name) | Name of the SLS project. Length must be 3-36 characters, starting and ending with lowercase letters or digits, containing only lowercase letters, digits, and hyphens | `string` | `"ack-hpa-sls-project"` | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | Category of the system disk | `string` | `"cloud_essd"` | no |
| <a name="input_system_disk_size"></a> [system\_disk\_size](#input\_system\_disk\_size) | Size of the system disk in GB | `number` | `40` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC | `string` | `"10.0.0.0/8"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | `"ack-hpa-vpc"` | no |
| <a name="input_vswitch1_cidr_block"></a> [vswitch1\_cidr\_block](#input\_vswitch1\_cidr\_block) | CIDR block for the first VSwitch | `string` | `"10.0.0.0/24"` | no |
| <a name="input_vswitch1_name"></a> [vswitch1\_name](#input\_vswitch1\_name) | Name of the first VSwitch | `string` | `"ack-hpa-vswitch1"` | no |
| <a name="input_vswitch2_cidr_block"></a> [vswitch2\_cidr\_block](#input\_vswitch2\_cidr\_block) | CIDR block for the second VSwitch | `string` | `"10.0.1.0/24"` | no |
| <a name="input_vswitch2_name"></a> [vswitch2\_name](#input\_vswitch2\_name) | Name of the second VSwitch | `string` | `"ack-hpa-vswitch2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_connections"></a> [cluster\_connections](#output\_cluster\_connections) | Connection information for the Kubernetes cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the ACK managed Kubernetes cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the ACK managed Kubernetes cluster |
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The ID of the NAT gateway |
| <a name="output_node_pool_id"></a> [node\_pool\_id](#output\_node\_pool\_id) | The ID of the node pool |
| <a name="output_ros_stack_id"></a> [ros\_stack\_id](#output\_ros\_stack\_id) | The ID of the ROS stack |
| <a name="output_ros_stack_status"></a> [ros\_stack\_status](#output\_ros\_stack\_status) | The status of the ROS stack |
| <a name="output_scaling_group_id"></a> [scaling\_group\_id](#output\_scaling\_group\_id) | The ID of the scaling group for the node pool |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_slb_id"></a> [slb\_id](#output\_slb\_id) | The ID of the API Server load balancer |
| <a name="output_sls_project_name"></a> [sls\_project\_name](#output\_sls\_project\_name) | The name of the SLS project |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch1_id"></a> [vswitch1\_id](#output\_vswitch1\_id) | The ID of the first VSwitch |
| <a name="output_vswitch2_id"></a> [vswitch2\_id](#output\_vswitch2\_id) | The ID of the second VSwitch |
| <a name="output_worker_ram_role_name"></a> [worker\_ram\_role\_name](#output\_worker\_ram\_role\_name) | The RAM role name attached to worker nodes |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交
[provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库上开启 issue。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可证。详情请参见 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)