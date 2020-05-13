variable "ibmcloud_api_key" {}

terraform {
  required_version = "~> 0.12"
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  generation = 2
  region = "us-south"
  ibmcloud_timeout = 300
  version = "~> 1.5"
}

module "iam_groups" {
  source          = "./modules/iam-groups-geographic"
  resource_group  = "default"
  create_policy   = true
}
