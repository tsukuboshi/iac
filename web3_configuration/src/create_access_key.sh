#!/bin/bash
# Run this shell in "terraform init" directory before executing "terraform apply".

if [ -f ~/.ssh/minimum_configuration.pem ]; then
  ssh-keygen -t rsa -f ~/.ssh/web_configuration.pem
else
  echo "You have already created access key."
fi
