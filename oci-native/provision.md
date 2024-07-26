# OCI NATIVE QUICKSTART
This solution is intended to quickstart an OKE cluster with the right and secure network setup.
We will use by default OCI Native Ingress. Support for external-dns is planned in the future.

The terraform scripts to provision the infrastructure can be run also in the cloud shell.

You should also have installed on your laptop an **SSH CLIENT** and also **OCI CLI**, **kubectl** and **helm**


## Provision the infrastructure

The network infrastructure must be created first, then the OKE cluster can be provisioned on top of it:

1. Modify terraform.tfvars.example in the oci-native folder. Rename it terraform.tfvars
2. terraform apply -target module.network
3. terraform apply

NOTE: If you are planning to reuse this solution, you will have an error with the OKE module whenever there is a terraform operation.  
To solve this, just define network and subnets statically in the code and link them to the OKE module.

## Connect to the bastion

You need to have a public and private SSH key pair on your laptop. You also need a SSH client and the OCI CLI installed.

1. Generate the key.json file to connect to a bastion:
```
oci bastion session create-session-create-dynamic-port-forwarding-session-target-resource-details --generate-param-json-input key-details > key.json
```
2. Copy your public key content, and paste it in the key.json file
3. Substitute the variables in the sample script

NOTE: The proxy server will run by default on localhost:8080, feel free to change the SOCKS5 port if needed

## Connect to OKE

1. Go to the cluster console, and click on "Connect Cluster"
2. Find the command to generate a Kubectl file using the PRIVATE_IP of the cluster
3. Execute the command
4. Modify the kubectl and specify your proxy server: https://kubernetes.io/docs/tasks/extend-kubernetes/socks5-proxy-access-api/
5. Test cluster connectivity

## Deploy OCI Native Ingress Controller

1. git clone https://github.com/oracle/oci-native-ingress-controller.git
2. cd oci-native-ingress-controller/helm/oci-native-ingress-controller
3. Edit values.yaml 
4. Set: compartment_id, subnet_id, cluster_id, authType: workloadIdentity, region 
5. helm install oci-native-ingress-controller .
6. Deploy yaml in native-ingress/ingress-example.yaml