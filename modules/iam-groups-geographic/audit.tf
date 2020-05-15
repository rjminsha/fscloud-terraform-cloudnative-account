locals {
  warning = "Can view, export and delete audit logs which may include customer sensitive information"
}
#############################
## Global groups
#############################

resource "ibm_iam_access_group" "global_audit_admin" {
  name        = "${var.prefix}-global-audit-admin"
  description = format("Group has %s role(s) for logdnaat globally.  %s", join(", ",var.audit_admin_roles), local.warning)
}
resource "ibm_iam_access_group_policy" "global_audit_admin" {
 access_group_id = "${ibm_iam_access_group.global_audit_admin.id}"
 roles           = var.audit_admin_roles
 resources {
   resource_group_id = data.ibm_resource_group.group.id
   service           = "logdnaat"
 }
 count = var.create_policy ? 1 : 0
}

resource "ibm_iam_access_group" "global_audit_privileged" {
  name        = "${var.prefix}-global-audit-privileged"
  description = format("Group has %s role(s) for logdnaat globally.  %s", join(", ",var.audit_privileged_roles), local.warning)
}
resource "ibm_iam_access_group_policy" "global_audit_privileged" {
 access_group_id = "${ibm_iam_access_group.global_audit_privileged.id}"
 roles           = var.audit_privileged_roles
 resources {
   resource_group_id = data.ibm_resource_group.group.id
   service           = "logdnaat"
 }
 count = var.create_policy ? 1 : 0
}

resource "ibm_iam_access_group" "global_audit_observer" {
  name        = "${var.prefix}-global-audit-observer"
  description = format("Group has %s role(s) for logdnaat globally. ", join(", ",var.audit_privileged_roles))
}
resource "ibm_iam_access_group_policy" "global_audit_observer" {
 access_group_id = "${ibm_iam_access_group.global_audit_observer.id}"
 roles           = ["Viewer"]
 resources {
   resource_group_id = data.ibm_resource_group.group.id
   service           = "logdnaat"
 }
 count = var.create_policy ? 1 : 0
}

#############################
## Groups per isolation zone
#############################

module "audit_admin_iz" {
  source                = "./iam-isolation-zone-policy-helper"
  group_roles           = var.audit_admin_roles
  group_name            = "audit-admin"
  group_description     = local.warning
  service               = "logdnaat"
  group_prefix          = var.prefix
  create_policy         = var.create_policy
  i_zones               = var.isolation_zones
  us_regions            = var.isolation_zones_us_regions
  eu_regions            = var.isolation_zones_eu_regions
  ap_regions            = var.isolation_zones_ap_regions
  resource_group_id     = data.ibm_resource_group.group.id
}

module "audit_privileged_iz" {
  source                = "./iam-isolation-zone-policy-helper"
  group_roles           = var.audit_privileged_roles
  group_name            = "audit-privileged"
  group_description     = local.warning
  service               = "logdnaat"
  group_prefix          = var.prefix
  create_policy         = var.create_policy
  i_zones               = var.isolation_zones
  us_regions            = var.isolation_zones_us_regions
  eu_regions            = var.isolation_zones_eu_regions
  ap_regions            = var.isolation_zones_ap_regions
  resource_group_id     = data.ibm_resource_group.group.id
}
