variable "ibmcloud_api_key" {}

terraform {
  required_version = ">= v0.13.5"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.21.1"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  generation = 2
  region = "us-south"
  ibmcloud_timeout = 300
}

module "iam_groups" {
  source          = "./modules/iam-groups-geographic"
  resource_group  = "default"
  create_policy   = true
}
