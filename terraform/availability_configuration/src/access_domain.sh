#!/bin/bash
# Run this shell in "terraform init" directory after executing "terraform apply".

DOMAIN_NAME="$(terraform output -json | jq -r .domain_name.value)"

if [ ! "${DOMAIN_NAME}" = null ]; then
  curl https://"${DOMAIN_NAME}" --insecure
else
  echo "Domain name is null."
fi
