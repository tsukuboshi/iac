#!/bin/bash
# Run this shell in "terraform init" directory after executing "terraform apply".

INSTANCE_ID="$(terraform output -json | jq -r .instance_id.value)"

if [ ! "${INSTANCE_ID}" = null ]; then
  ssh -i ~/.ssh/minimum_tf.pem ec2-user@"${INSTANCE_ID}"
else
  echo "Instance public ip is null."
fi
