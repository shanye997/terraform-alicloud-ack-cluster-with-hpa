provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_instance_type    = data.alicloud_instance_types.default.ids[0]
  available_slb_address_type = "classic_internet"
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
}

data "alicloud_ram_roles" "roles" {
  policy_type = "Custom"
  name_regex  = "^Aliyun.*Role$"
}

resource "random_integer" "default" {
  min = 100000
  max = 999999
}

module "ack_hpa_cluster" {
  source = "../.."

  # VPC Configuration
  vpc = {
    cidr_block = var.vpc_cidr_block
    name       = "${var.common_name}-vpc"
  }

  # VSwitch Configuration
  vswitches = [
    {
      zone_id      = data.alicloud_zones.default.zones[0].id
      cidr_block   = var.vswitch1_cidr_block
      vswitch_name = "${var.common_name}-vswitch1"
    },
    {
      zone_id      = data.alicloud_zones.default.zones[1].id
      cidr_block   = var.vswitch2_cidr_block
      vswitch_name = "${var.common_name}-vswitch2"
    }
  ]

  # Security Group Configuration
  security_group = {
    name = "${var.common_name}-sg"
    rules = [
      {
        type        = "ingress"
        ip_protocol = "tcp"
        port_range  = "443/443"
        cidr_ip     = var.vpc_cidr_block
      },
      {
        type        = "ingress"
        ip_protocol = "tcp"
        port_range  = "80/80"
        cidr_ip     = var.vpc_cidr_block
      }
    ]
  }

  # SLS Configuration
  sls_project = {
    name = "${var.sls_project_name}-${random_integer.default.result}"
  }

  # ACK Cluster Configuration
  ack_cluster = {
    name                 = var.managed_kubernetes_cluster_name
    cluster_spec         = var.cluster_spec
    service_cidr         = var.service_cidr
    new_nat_gateway      = true
    slb_internet_enabled = true
    addons = [
      {
        name     = "ack-node-local-dns"
        config   = ""
        version  = ""
        disabled = false
      },
      {
        name     = "terway-eniip"
        config   = "{\"IPVlan\":\"false\",\"NetworkPolicy\":\"false\",\"ENITrunking\":\"false\"}"
        version  = ""
        disabled = false
      },
      {
        name     = "csi-plugin"
        config   = ""
        version  = ""
        disabled = false
      },
      {
        name     = "csi-provisioner"
        config   = ""
        version  = ""
        disabled = false
      },
      {
        name     = "storage-operator"
        config   = "{\"CnfsOssEnable\":\"false\",\"CnfsNasEnable\":\"false\"}"
        version  = ""
        disabled = false
      },
      {
        name     = "nginx-ingress-controller"
        config   = ""
        version  = ""
        disabled = true
      },
      {
        name     = "logtail-ds"
        config   = "{\"IngressDashboardEnabled\":\"true\"}"
        version  = ""
        disabled = false
      },
      {
        name     = "alb-ingress-controller"
        config   = ""
        version  = ""
        disabled = false
      },
      {
        name     = "ack-helm-manager"
        config   = ""
        version  = ""
        disabled = false
      },
      {
        name     = "arms-prometheus"
        config   = ""
        version  = ""
        disabled = false
      }
    ]
    delete_options = [
      {
        delete_mode   = "delete"
        resource_type = "ALB"
      },
      {
        delete_mode   = "delete"
        resource_type = "SLB"
      },
      {
        delete_mode   = "delete"
        resource_type = "SLS_Data"
      },
      {
        delete_mode   = "delete"
        resource_type = "SLS_ControlPlane"
      },
      {
        delete_mode   = "delete"
        resource_type = "PrivateZone"
      }
    ]
  }

  # Node Pool Configuration
  node_pool = {
    name                 = "${var.common_name}-nodepool"
    instance_types       = [data.alicloud_instance_types.default.ids[0]]
    system_disk_category = var.system_disk_category
    system_disk_size     = var.system_disk_size
    runtime_name         = var.runtime_name
    runtime_version      = var.runtime_version
    scaling_config = {
      enable   = true
      min_size = var.scaling_config_min_size
      max_size = var.scaling_config_max_size
    }
  }

  # ROS Stack Configuration
  ros_stack = {
    stack_name = "${var.common_name}-k8s-resource-${random_integer.default.result}"
  }

  # RAM Configuration
  ram = {
    existing_role_names = [for role in data.alicloud_ram_roles.roles.roles : role.name]
  }
}
