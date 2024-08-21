#!/bin/bash

export BASTION_ID=<bastion-id>
export SESSION_NAME=<session-name>
export REGION=<region>
export KEY_PATH="file://$HOME/key.json"
export PRIVATE_KEY_PATH=<path-to-private-key>


SESSION_ID=$(oci bastion session list --bastion-id $BASTION_ID --display-name $SESSION_NAME --session-lifecycle-state ACTIVE --limit 1 --region $REGION --raw-output --query "data[0].id")
# Create session if it does not exists
[ -z "$SESSION_ID" ] && SESSION_ID=$(oci bastion session create-session-create-dynamic-port-forwarding-session-target-resource-details --bastion-id $BASTION_ID --key-details $KEY_PATH --display-name $SESSION_NAME --session-ttl-in-seconds 10800 --wait-for-state SUCCEEDED --region $REGION --query "data.id" --raw-output)

ssh -i $PRIVATE_KEY_PATH -N -D 127.0.0.1:8080 -p 22 $SESSION_ID@host.bastion.$REGION.oci.oraclecloud.com