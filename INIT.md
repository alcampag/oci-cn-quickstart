# Running the quickstart
Run the following commands, you will be asked the compartment id where to deploy
the OKE cluster:

1. cd ./${OCI_CCL_DESTINATION_DIR}/oke
2. Get the compartment id where you want to deploy the solution
3. Check the default variable.tf values
4. chmod +x init.sh
5. ./init.sh -c <compartment_id>

Note: If you want to deploy in another region, set the OCI_REGION env value appropriately