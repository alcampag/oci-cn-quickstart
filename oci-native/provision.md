
tofu apply -target module.network -auto-approve
tofu apply -auto-approve


git clone https://github.com/oracle/oci-native-ingress-controller.git

cd oci-native-ingress-controller/helm/oci-native-ingress-controller

# Edit values.yaml
## Set: compartment_id, subnet_id, cluster_id, authType: workloadIdentity, region
### helm install oci-native-ingress-controller .