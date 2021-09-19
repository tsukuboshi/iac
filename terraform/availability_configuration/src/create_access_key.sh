#!/bin/bash
# Run this shell before executing "terraform apply".

if [ -f ~/.ssh/minimum_configuration.pem ]; then
  ssh-keygen -t rsa -f ~/.ssh/availability_configuration.pem
else
  echo "You have already created access key."
fi
