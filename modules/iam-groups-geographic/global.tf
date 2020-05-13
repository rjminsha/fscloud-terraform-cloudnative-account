############################
## GLOBAL IAM Access Groups
############################
resource "ibm_iam_access_group" "global_admin" {
  name        = "${var.prefix}-global-admin"
  description = "Global team that has super user access across regions for the resource group"
}
resource "ibm_iam_access_group_policy" "global_admin" {
 access_group_id = "${ibm_iam_access_group.global_admin.id}"
 roles           = ["Administrator", "Manager"]
 resources {
   resource_group_id = data.ibm_resource_group.group.id
 }
 count = var.create_policy ? 1 : 0
}

resource "ibm_iam_access_group" "global_observer" {
  name        = "${var.prefix}-global-observer"
  description = "Group can view all resources for the resource group"
}

resource "ibm_iam_access_group_policy" "global_observer" {
 access_group_id = "${ibm_iam_access_group.global_observer.id}"
 roles           = ["Viewer", "Reader"]
 resources {
   resource_group_id = data.ibm_resource_group.group.id
 }
 count = var.create_policy ? 1 : 0
}

resource "ibm_iam_access_group" "global_registry_pull" {
  name        = "${var.prefix}-global-registry-pull"
  description = "Group can pull container images from Container Registry"
}

resource "ibm_iam_access_group_policy" "global_registry_pull" {
 access_group_id = "${ibm_iam_access_group.global_registry_pull.id}"
 roles           = ["Reader"]
 resources {
   resource_group_id = data.ibm_resource_group.group.id
   service           = "container-registry"
 }
 count = var.create_policy ? 1 : 0
}

resource "ibm_iam_access_group" "global_registry_push" {
  name        = "${var.prefix}-global-registry-push"
  description = "Group can push container images to the Container Registry"
}

resource "ibm_iam_access_group_policy" "global_registry_push" {
 access_group_id = "${ibm_iam_access_group.global_registry_push.id}"
 roles           = ["Editor"]
 resources {
   resource_group_id = data.ibm_resource_group.group.id
   service           = "container-registry"
 }
 count = var.create_policy ? 1 : 0
}
