#!/bin/bash
# Run this shell in "terraform init" directory before executing "terraform apply".

if [ -f ~/.ssh/minimum_configuration.pem ]; then
  echo "You have already created access key."
else
  ssh-keygen -t rsa -f ~/.ssh/minimum_configuration.pem
fi
