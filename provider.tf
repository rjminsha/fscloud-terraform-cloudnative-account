provider "ibm" {
  alias            = "parent-provider"
  ibmcloud_api_key = var.ibmcloud_api_key
  generation       = 2
  region           = var.region
}
