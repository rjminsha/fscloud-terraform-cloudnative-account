variable "resource_group" {
  default = "default"
  description = "The name of resource group to deploy resources into"
}


variable "create_policy" {
  description = "If true will create set of default polices for IAM access groups.  If false will simply create iam access groups"
  default = true
}

variable "prefix" {
  description = "Prefix for resource names"
  default = "fscloud"
}

################################
## Roles assigned to access groups
################################
variable "audit_admin_roles" {
  type = list(string)
  default = ["Administrator", "Manager"]
}
variable "audit_priviledged_roles" {
  type = list(string)
  default = ["Operator", "Manager"]
}

################################
## Regions for each isolation zone
################################
variable "isolation_zones" {
  description = "Create IAM groups based on these isolation zones.  An isolation zone is typically a national or geographic boundary for which specific contracts or compliance regulations apply"
  type        = list(string)
  default     = ["us", "eu", "ap"]
}

variable "isolation_zones_us_regions" {
  description = "Regions in us isolation zones"
  type        = list(string)
  default     = ["us-south", "us-east"]
}

variable "isolation_zones_eu_regions" {
  description = "Regions in eu isolation zones"
  type        = list(string)
  default     = ["eu-de", "eu-gb"]
}

variable "isolation_zones_ap_regions" {
  description = "Regions in asia pacific isolation zone"
  type        = list(string)
  default     = ["jp-tok", "jp-osa", "kr-seo", "au-syd"]
}
