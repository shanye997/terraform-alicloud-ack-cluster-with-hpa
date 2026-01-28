locals {
  cs_roles = [
    {
      name            = "AliyunCSManagedLogRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The log component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedLogRolePolicy"
    },
    {
      name            = "AliyunCSManagedCmsRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The CMS component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCmsRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The storage component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCsiRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiPluginRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The storage component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCsiPluginRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiProvisionerRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The storage component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedCsiProvisionerRolePolicy"
    },
    {
      name            = "AliyunCSManagedVKRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The VK component of ACK Serverless cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedVKRolePolicy"
    },
    {
      name            = "AliyunCSServerlessKubernetesRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster uses this role by default to access your resources in other cloud products."
      policy_name     = "AliyunCSServerlessKubernetesRolePolicy"
    },
    {
      name            = "AliyunCSKubernetesAuditRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster audit function uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSKubernetesAuditRolePolicy"
    },
    {
      name            = "AliyunCSManagedNetworkRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster network component uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedNetworkRolePolicy"
    },
    {
      name            = "AliyunCSDefaultRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster uses this role by default during cluster operations to access your resources in other cloud products."
      policy_name     = "AliyunCSDefaultRolePolicy"
    },
    {
      name            = "AliyunCSManagedKubernetesRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster uses this role by default to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedKubernetesRolePolicy"
    },
    {
      name            = "AliyunCSManagedArmsRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The cluster Arms plugin uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedArmsRolePolicy"
    },
    {
      name            = "AliyunCISDefaultRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "Container Service (CS) intelligent operations uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCISDefaultRolePolicy"
    },
    {
      name            = "AliyunOOSLifecycleHook4CSRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"oos.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "Cluster scaling node pools depend on OOS service, OOS uses this role to access your resources in other cloud products."
      policy_name     = "AliyunOOSLifecycleHook4CSRolePolicy"
    },
    {
      name            = "AliyunCSManagedAutoScalerRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "The auto scaling component of the cluster uses this role to access your resources in other cloud products."
      policy_name     = "AliyunCSManagedAutoScalerRolePolicy"
    }
  ]

  all_role_names   = [for role in local.cs_roles : role.name]
  complement_names = setsubtract(local.all_role_names, var.ram.existing_role_names)
  complement_roles = [for role in local.cs_roles : role if contains(local.complement_names, role.name)]

  # Create a map of role name to role object for easy lookup
  complement_roles_map = { for r in local.complement_roles : r.name => r }

  # Use var.ros_stack.parameters if not null, otherwise use default parameters
  ros_parameters = var.ros_stack.parameters != null ? var.ros_stack.parameters : [
    {
      parameter_key   = "cluster_id"
      parameter_value = alicloud_cs_managed_kubernetes.ack.id
    },
    {
      parameter_key   = "sls_project_name"
      parameter_value = alicloud_log_project.sls_project.project_name
    }
  ]
}

resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc.cidr_block
  vpc_name   = var.vpc.name
}

resource "alicloud_vswitch" "vswitches" {
  for_each = {
    for vswitch in var.vswitches :
    vswitch.cidr_block => vswitch
  }

  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = each.value.cidr_block
  zone_id      = each.value.zone_id
  vswitch_name = each.value.vswitch_name
}

resource "alicloud_security_group" "sg" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group.name
}

resource "alicloud_security_group_rule" "rules" {
  for_each = {
    for idx, rule in var.security_group.rules :
    "${rule.type}-${rule.ip_protocol}-${rule.port_range}" => rule
  }

  security_group_id = alicloud_security_group.sg.id
  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  port_range        = each.value.port_range
  cidr_ip           = each.value.cidr_ip
}

resource "alicloud_log_project" "sls_project" {
  project_name = var.sls_project.name
}

resource "alicloud_cs_managed_kubernetes" "ack" {
  depends_on = [
    alicloud_ram_role.role,
    alicloud_ram_role_policy_attachment.attach
  ]
  name                 = var.ack_cluster.name
  cluster_spec         = var.ack_cluster.cluster_spec
  vswitch_ids          = [for vswitch in alicloud_vswitch.vswitches : vswitch.id]
  pod_vswitch_ids      = [for vswitch in alicloud_vswitch.vswitches : vswitch.id]
  service_cidr         = var.ack_cluster.service_cidr
  new_nat_gateway      = var.ack_cluster.new_nat_gateway
  slb_internet_enabled = var.ack_cluster.slb_internet_enabled
  security_group_id    = alicloud_security_group.sg.id

  dynamic "addons" {
    for_each = var.ack_cluster.addons
    content {
      name     = addons.value.name
      config   = lookup(addons.value, "config", "")
      version  = lookup(addons.value, "version", "")
      disabled = lookup(addons.value, "disabled", false)
    }
  }

  dynamic "delete_options" {
    for_each = var.ack_cluster.delete_options
    content {
      delete_mode   = delete_options.value.delete_mode
      resource_type = delete_options.value.resource_type
    }
  }
}

resource "alicloud_cs_kubernetes_node_pool" "node_pool" {
  node_pool_name       = var.node_pool.name
  cluster_id           = alicloud_cs_managed_kubernetes.ack.id
  vswitch_ids          = [for vswitch in alicloud_vswitch.vswitches : vswitch.id]
  instance_types       = var.node_pool.instance_types
  system_disk_category = var.node_pool.system_disk_category
  system_disk_size     = var.node_pool.system_disk_size

  runtime_name    = var.node_pool.runtime_name
  runtime_version = var.node_pool.runtime_version

  scaling_config {
    enable   = var.node_pool.scaling_config.enable
    min_size = var.node_pool.scaling_config.min_size
    max_size = var.node_pool.scaling_config.max_size
  }
}

resource "alicloud_ros_stack" "deploy_k8s_resource" {
  stack_name   = var.ros_stack.stack_name
  template_url = var.ros_stack.template_url

  dynamic "parameters" {
    for_each = local.ros_parameters
    content {
      parameter_key   = parameters.value.parameter_key
      parameter_value = parameters.value.parameter_value
    }
  }

  disable_rollback = var.ros_stack.disable_rollback
  depends_on       = [alicloud_cs_kubernetes_node_pool.node_pool]
}

resource "alicloud_ram_role" "role" {
  for_each                    = local.complement_roles_map
  role_name                   = each.value.name
  assume_role_policy_document = each.value.policy_document
  description                 = each.value.description
  force                       = var.ram.role_force
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  for_each    = alicloud_ram_role.role
  policy_name = local.complement_roles_map[each.key].policy_name
  policy_type = var.ram.policy_type
  role_name   = each.value.role_name
}
