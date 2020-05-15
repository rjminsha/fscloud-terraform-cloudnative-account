############################
## Groups per isolation zone
############################

module "iz_admin" {
  source                = "./iam-isolation-zone-policy-helper"
  group_roles           = var.admin_roles
  group_name            = "admin"
  group_prefix          = var.prefix
  create_policy         = var.create_policy
  i_zones               = var.isolation_zones
  us_regions            = var.isolation_zones_us_regions
  eu_regions            = var.isolation_zones_eu_regions
  ap_regions            = var.isolation_zones_ap_regions
  resource_group_id     = data.ibm_resource_group.group.id
}

module "iz_observer" {
  source                = "./iam-isolation-zone-policy-helper"
  group_roles           = var.observer_roles
  group_name            = "observer"
  group_prefix          = var.prefix
  create_policy         = var.create_policy
  i_zones               = var.isolation_zones
  us_regions            = var.isolation_zones_us_regions
  eu_regions            = var.isolation_zones_eu_regions
  ap_regions            = var.isolation_zones_ap_regions
  resource_group_id     = data.ibm_resource_group.group.id
}

module "iz_emerg" {
  source                = "./iam-isolation-zone-policy-helper"
  group_roles           = var.privileged_roles
  group_name            = "emergency-operator"
  group_prefix          = var.prefix
  create_policy         = var.create_policy
  i_zones               = var.isolation_zones
  us_regions            = var.isolation_zones_us_regions
  eu_regions            = var.isolation_zones_eu_regions
  ap_regions            = var.isolation_zones_ap_regions
  resource_group_id     = data.ibm_resource_group.group.id
}
