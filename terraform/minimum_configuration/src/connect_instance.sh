#!/bin/bash
# Run this shell after executing "terraform apply".

INSTANCE_PUBLIC_IP="$(terraform output -json | jq -r .instance_public_ip.value)"

if [ ! "${INSTANCE_PUBLIC_IP}" = null ]; then
  ssh -i ~/.ssh/minimum_configuration.pem ec2-user@"${INSTANCE_PUBLIC_IP}"
else
  echo "Instance public ip is null."
fi