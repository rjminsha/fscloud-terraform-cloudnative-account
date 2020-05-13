#######################
## local helper module to create iam access groups per isolation zones with policy created for each zone within the isolation zone
#  Example usage:
#       module "general-group" {
#         source                = "./iam-policy-helper"
#         group_roles           = ["Operator", "Manager"]
#         group_name            = "mytest"
#         group_description     = "my test description"
#         group_prefix          = var.prefix
#         i_zones               = var.isolation_zones
#         us_regions            = var.isolation_zones_us_regions
#         eu_regions            = var.isolation_zones_eu_regions
#         ap_regions            = var.isolation_zones_ap_regions
#         resource_group_id     = data.ibm_resource_group.group.id
#       }
#
#       module "service-specific-group" {
#         source                = "./iam-policy-helper"
#         group_roles           = ["Operator", "Manager"]
#         group_name            = "mytest2"
#         group_description     = "my test description"
#         service               = "container-registry"
#         group_prefix          = var.prefix
#         i_zones               = var.isolation_zones
#         us_regions            = var.isolation_zones_us_regions
#         eu_regions            = var.isolation_zones_eu_regions
#         ap_regions            = var.isolation_zones_ap_regions
#         create                = var.create_policy_policy
#         resource_group_id     = data.ibm_resource_group.group.id
#       }
#
#######################

variable "group_roles" {
  type        = list(string)
}

variable "group_name" {
  type        = string
}

variable "group_prefix" {
  type        = string
}

variable "group_description" {
  type        = string
  default     = ""
}

variable "i_zones" {
  type        = list(string)
}
variable "us_regions" {
  type        = list(string)
}
variable "eu_regions" {
  type        = list(string)
}
variable "ap_regions" {
  type        = list(string)
}
variable "resource_group_id" {
  type        = string
}

variable "service" {
  type        = string
  default     = ""
}

variable "create_policy" {
}

locals {
  role_string = join(", ", var.group_roles)
  owner        = "Community Team"
}

## Create service specific policy
resource "ibm_iam_access_group" "iz-s" {
  name        = "${var.group_prefix}-${var.i_zones[count.index]}-${var.group_name}"
  description     = format("Group has %s role(s) for %s in %s isolation zone.  %s", local.role_string, var.service, upper(var.i_zones[count.index]), var.group_description)
  count =  var.service != "" ? length(var.i_zones) : 0
}
resource "ibm_iam_access_group_policy" "iz_service_us" {
  access_group_id = "${ibm_iam_access_group.iz-s[0].id}"
  roles           = var.group_roles
  resources {
    service = var.service
    region = "${var.us_regions[count.index]}"
    resource_group_id = var.resource_group_id
  }
  count = var.service != "" && var.create_policy ? length(var.us_regions) : 0
}
resource "ibm_iam_access_group_policy" "iz_service_eu" {
  access_group_id = "${ibm_iam_access_group.iz-s[1].id}"
  roles           = var.group_roles
  resources {
    service = var.service
    region = "${var.eu_regions[count.index]}"
    resource_group_id = var.resource_group_id
  }
  count = var.service != "" && var.create_policy ? length(var.eu_regions) : 0
}
resource "ibm_iam_access_group_policy" "iz_service_ap" {
  access_group_id = "${ibm_iam_access_group.iz-s[2].id}"
  roles           = var.group_roles
  resources {
    service = var.service
    region = "${var.ap_regions[count.index]}"
    resource_group_id = var.resource_group_id
  }
  count = var.service != "" && var.create_policy ? length(var.ap_regions) : 0
}

## Create policy when no Service is passed in
resource "ibm_iam_access_group" "iz" {
  name        = "${var.group_prefix}-${var.i_zones[count.index]}-${var.group_name}"
  description     = format("Group has %s role(s) in %s isolation zone.  %s", local.role_string, upper(var.i_zones[count.index]), var.group_description)
  count =  var.service == "" ? length(var.i_zones) : 0
}
resource "ibm_iam_access_group_policy" "iz_us" {
  access_group_id = "${ibm_iam_access_group.iz[0].id}"
  roles           = var.group_roles
  resources {
    region = "${var.us_regions[count.index]}"
    resource_group_id = var.resource_group_id
  }
  count = var.service == "" && var.create_policy ? length(var.us_regions) : 0
}
resource "ibm_iam_access_group_policy" "iz_eu" {
  access_group_id = "${ibm_iam_access_group.iz[1].id}"
  roles           = var.group_roles
  resources {
    region = "${var.eu_regions[count.index]}"
    resource_group_id = var.resource_group_id
  }
  count = var.service == "" && var.create_policy ? length(var.eu_regions) : 0
}
resource "ibm_iam_access_group_policy" "iz_ap" {
  access_group_id = "${ibm_iam_access_group.iz[2].id}"
  roles           = var.group_roles
  resources {
    region = "${var.ap_regions[count.index]}"
    resource_group_id = var.resource_group_id
  }
  count = var.service == "" && var.create_policy ? length(var.ap_regions) : 0
}

output "groups" {
  value = var.service == "" ? ibm_iam_access_group.iz.* : ibm_iam_access_group.iz-s.*
}
