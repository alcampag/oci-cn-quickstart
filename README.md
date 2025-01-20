# OKE Quickstart

This repository was created with the intent of facilitating users with the creation of an OKE cluster from scratch.

The plan is to have a documentation and some stacks for the majority of use cases.

In this repository we are going to provision all the components one by one (network, OKE control plane, OKE data plane)

NOTE: If you want to create an OKE cluster with GPU and RDMA, then the stack that creates everything is public and available [here](https://github.com/oracle-quickstart/oci-hpc-oke)

Plan is to have a repo with a stack that creates a OKE cluster FOR the majority of the use cases
Here we want to create all the components one by one (network, OKE control plane, OKE data plane).
NOTE: if you want to create an OKE cluster with GPU and RDMA, then the stack that creates everything is public and is here[link]

Step 1: Create the network infrastructure for OKE

Step 2: Create the OKE control plane only

Step 3: Create the OKE data plane

	Option 3.1: Create the OKE data plane with OL nodes (CPU only, GPU restricted, no metrics with DCGM exporter)
		Option 3.1.1: Manually (through the OCI web console)
		Option 3.1.2: Edit the RM stack and modify the terraform code

	Option 3.2: Create the OKE data plane with Ubuntu nodes (CPU, GPU only)
		Option 3.2.1: Edit the RM stack and modify the terraform code
	
	Option 3.3 Create the OKE data plane with Ubuntu nodes (GPU and RDMA)
		Option 3.3.1: Ask EMEA Specialists to get information to do that with a predefined solution


## Step 1: Create the network infrastructure for OKE

This stack is used to create the initial network infrastructure for OKE. When configuring it, pay attention to some details:
* Select Flannel as CNI if you are planning to use Bare Metal shapes for the OKE data plane, or if you do not have many IPs available in the VCN
* You can apply this stack even on an existing VCN, so that only the NSGs for OKE will be created
* By default, everything is private, but there is the possibility to create public subnets
* Be careful when modifying the default values, as inputs are not validated

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/alcampag/oci-cn-quickstart/releases/latest/download/infra_v1.0.3.zip)

## Step 2: Create the OKE control plane

This stack is used to create the OKE control plane ONLY.

NOTE: if you are planning to use Ubuntu nodes for the data plane, be sure to select v1.29.1 as OKE version, as currently it's the only version that is supporting Ubuntu nodes.

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/alcampag/oci-cn-quickstart/releases/latest/download/oke_v1.0.3.zip)

Also note that if the network infrastructure is located in a different compartment than the OKE cluster AND you are planning to use the OCI_VCN_NATIVE CNI,
you must add these policies:

```ignorelang
Allow any-user to manage instances in tenancy where all { request.principal.type = 'cluster' }
Allow any-user to use private-ips in tenancy where all { request.principal.type = 'cluster' }
Allow any-user to use network-security-groups in tenancy where all { request.principal.type = 'cluster' }
```
For a more restrictive set of policies, see the [documentation](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengpodnetworking_topic-OCI_CNI_plugin.htm).

## Step 3: Create the OKE data plane

As the data plane vastly depends on the particular use case, there is no stack for it, and it depends mostly on your needs, as there are many options.

### Option 3.1: Create the OKE data plane with Oracle Linux nodes

This option is most commonly used for general purpose CPU workloads.

Although GPU workloads are supported too, the DCGM exporter to collect GPU metrics is still not available, so take this into account if you are planning to use Oracle Linux nodes and GPUs.

#### Option 3.1.1: Create worker nodes manually through the OCI web console

In some cases, some users prefer to create the nodes directly using the OCI web console. In this case there is nothing else to do, you are free to login and create the node pools.

#### Option 3.1.2: Create worker nodes by modifying the Terraform Resource Manager stack

It is possible in OCI to easily modify the Terraform code of an OCI Resource Manager stack.

This way, we can modify the stack we deployed in Step 2 and add the data plane nodes:

