#############################
## global (global.tf)
#############################
output "global_admin" {
  value = ibm_iam_access_group.global_admin
  description = "Global IAM Access Group that has super user access across regions for the resource group"
}
output "global_observer" {
  value = ibm_iam_access_group.global_observer
  description = "Global IAM access access group can view all resources for the resource group"
}

output "global_registry_pull" {
  value = ibm_iam_access_group.global_registry_pull
  description = "Global IAM Access Group can pull container images from Container Registry"
}

output "global_registry_push" {
  value = ibm_iam_access_group.global_registry_push
  description = "Global IAM Access Group can push container images to the Container Registry"
}

#############################
## general roles per isolation zone (main.tf)
#############################
## admin
output "isolation_zone_admin_us" {
  value = module.iz_admin.groups[0]
  description = "IAM Access Group has admin rights for the US isolation zone"
}
output "isolation_zone_admin_eu" {
  value = module.iz_admin.groups[1]
  description = "IAM Access Group has admin rights for the EU isolation zone"
}
output "isolation_zone_admin_ap" {
  value = module.iz_admin.groups[2]
  description = "IAM Access Group has admin rights for the AP isolation zone"
}
## observer
output "isolation_zone_observer_us" {
  value = module.iz_observer.groups[0]
  description = "IAM Access Group has permission to view resources for the US isolation zone"
}
output "isolation_zone_observer_eu" {
  value = module.iz_observer.groups[1]
  description = "IAM Access Group has permission to view resources for the EU isolation zone"
}
output "isolation_zone_observer_ap" {
  value = module.iz_observer.groups[2]
  description = "IAM Access Group has permission to view resources for the AP isolation zone"
}
## emergency access
output "isolation_zone_emerg_us" {
  value = module.iz_emerg.groups[0]
  description = "IAM Access Group has emergency privileged operator access to the US isolation zone"
}
output "isolation_zone_emerg_eu" {
  value = module.iz_emerg.groups[1]
  description = "IAM Access Group has emergency privileged operator access to the EU isolation zone"
}
output "isolation_zone_emerg_ap" {
  value = module.iz_emerg.groups[2]
  description = "IAM Access Group has emergency privileged operator access to the AP isolation zone"
}

#############################
## audit
#############################
output "audit_admin_global" {
  value = ibm_iam_access_group.global_audit_admin
}
output "audit_privileged_global" {
  value = ibm_iam_access_group.global_audit_privileged
}
output "audit_admin_us" {
  value = module.audit_admin_iz.groups[0]
}
output "audit_admin_eu" {
  value = module.audit_admin_iz.groups[1]
}
output "audit_admin_ap" {
  value = module.audit_admin_iz.groups[2]
}
