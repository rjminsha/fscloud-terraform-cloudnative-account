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
