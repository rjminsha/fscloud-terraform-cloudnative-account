# IBM FSCloud Account Setup Module
This repository contains a Module for basic IBM Cloud Account setup typical for regulated industries and of reference architecture(s) for IBM Financial Services Ready Public Cloud.  It currently sets up basic IAM Access Groups and Policy but will be extended to include audit logging and retention.  It uses IBM Cloud Terraform Provider which is documented [here](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started).  

## IAM Access Groups and Policies
#### Summary
This module will create a set of IAM groups providing admin, privileged and observer permissions for a set of geographic isolations zones (US, EU, AP).  Access will further be broken by by audit, vpc, kubernetes and data services.  Users of this module can select if IAM policies should be created and assigned to groups of simply if groups should be created.  

#### Details
IBM Cloud supports two types of Roles: Platform access roles and Service access roles.  Platform management roles cover a range of actions, including the ability to create and delete instances, manage aliases, bindings, and credentials, and manage access and IBM Cloud. The platform roles are `administrator, editor, operator, viewer`.  Service access roles define a user or service’s ability to perform actions on a service instance, such as accessing the console or performing API calls.The service access roles are `manager, writer, and reader`

For ease of management (fewer access groups) this module creates groups and policy that combines both Platform and Management roles:
- admin (Administrator, Viewer)
- privileged (Operator, Manager)
- observer (Viewer, Reader)

Service permissions are then combined into
- global
- global audit logs
- geographic audit logs
- geographic vpc
- geographic kubernetes
- geographic data services

## Who maintains this module
This module is currently offered as an example and is provided by and supported by rjminsha@us.ibm.com.  Support for the IBM Cloud Provider is provided via GitHub, Slack and IBM Support.  Details can be provide [here](https://cloud.ibm.com/docs/terraform?topic=terraform-gettinghelp)

## References
- [IBM Terraform Provider documentation](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started)
- [IBM Terraform Provider GitHub repository](https://github.com/IBM-Cloud/terraform-provider-ibm)
- [IBM Kubernetes on Virtual Private Cloud Terraform example](https://github.com/ibm-cloud-architecture/refarch-public-iaas-iks)
- [IBM Cloud IAM documentation](https://cloud.ibm.com/docs/iam?topic=iam-userroles)
