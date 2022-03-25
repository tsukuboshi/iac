#!/bin/bash
# Run this shell in "terraform init" directory before executing "terraform apply".

ALB_DNS_NAME="$(terraform output -json | jq -r .alb_dns_name.value)"

watch -n 1 "curl ${ALB_DNS_NAME}"
