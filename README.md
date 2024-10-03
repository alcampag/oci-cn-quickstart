# Oracle Cloud Quickstart Cloud Native

This repository was created with the intent of facilitating users with their Cloud Native journey.

OKE is the managed Kubernetes offering of Oracle Cloud, but getting started with it can be a challenging task from an
infrastructure perspective.  
By providing this repository and Terraform code, it could serve as an example for users to get started with.
  
This repository is structured in various "stacks", and depending on the situation and purposes different stacks can be deployed.

## Stack 1: OKE Cluster with official module

This stack is ideal for all those users who want to provision an OKE cluster on the fly and try it.  
Both the infrastructure and the cluster is created by the same OKE [module](https://github.com/oracle-terraform-modules/terraform-oci-oke).  
To encourage users to explore the Terraform code, this solution can be deployed directly in the cloud shell, just click the link below and follow the instructions:

[![Open in Code Editor](https://raw.githubusercontent.com/oracle-devrel/oci-code-editor-samples/main/images/open-in-code-editor.png)](https://cloud.oracle.com/?region=home&cs_repo_url=https://github.com/alcampag/oci-cn-quickstart.git&cs_branch=main&cs_readme_path=INIT.md&cs_open_ce=false)


## Stack 2: Infrastructure + OKE Cluster creation

The stack here is more advances and it involves 2 phases: infrastructure creation and OKE cluster creation.  
Note that the input of these stacks are not validated, it is the user's responsibility to provide the correct input and eventually implement validation.

### Phase 1: Provision the network infrastructure for OKE

The first phase involves provisioning the network infrastructure for OKE. All the Terraform code here can be used as a reference:

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/alcampag/oci-native-rm/infra/release/infra_v1.zip)

### Phase 2: OKE Cluster provisioning

This additional stack will create a OKE cluster by using the infrastructure created on phase 1.

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/alcampag/oci-native-rm/oke/release/oke_v1.zip)

NOTE: In this stack the node pools are not created, and it is left to the user to modify this stack to include the node pools needed.
To do this, an example of node pool creation is present in the Stack 1.
  
Also note that if the network infrastructure is located in a different compartment than the OKE cluster AND you are planning to use the OCI_VCN_NATIVE CNI,
you must add these policies:

```ignorelang
Allow any-user to manage instances in tenancy where all { request.principal.type = 'cluster' }
Allow any-user to use private-ips in tenancy where all { request.principal.type = 'cluster' }
Allow any-user to use network-security-groups in tenancy where all { request.principal.type = 'cluster' }
```
For a more restrictive set of policies, see the [documentation](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengpodnetworking_topic-OCI_CNI_plugin.htm).