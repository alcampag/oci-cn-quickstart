#!/bin/bash

unset -v compartment_id;

while getopts c: flag
do
    case "${flag}" in
        c) compartment_id=${OPTARG};;
        *) echo 'Error in command line parsing' >&2
           exit 1
    esac
done

#shift "$(( OPTIND - 1 ))"  -----> to say that only 1 parameter is mandatory

if [ -z "$compartment_id" ]; then
        echo 'Missing -c (compartment_id)' >&2
        exit 1
fi

tofu init || exit
tofu apply -var="tenancy_ocid=$OCI_TENANCY" -var="region=$OCI_REGION" -var="compartment_ocid=$compartment_id" || exit