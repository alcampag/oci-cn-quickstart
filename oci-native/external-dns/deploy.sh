#!/bin/bash
kubectl create ns external-dns
kubectl create secret generic external-dns-config --from-file=oci.yaml -n external-dns
kubectl apply -f manifest.yaml


