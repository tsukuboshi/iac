#!/bin/bash
# Run this shell in "terraform init" directory before executing "terraform apply".

AWS_PROFILE=tf-demo
HOSTED_ZONE="$(aws route53 list-hosted-zones)"
DOMAIN_NAME="$(cat terraform.tfvars | grep domain | awk '{printf $3}' | sed 's/"//g')"

if [ "${HOSTED_ZONE}" = null ]; then
  aws route53 create-hosted-zone --name "${DOMAIN_NAME}" --caller-reference $(date +%Y-%m-%d_%H-%M-%S)
else
  echo "You have already created hosted zone."
fi
