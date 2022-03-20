#!/bin/bash
# Run this shell in "terraform init" directory before executing "terraform apply".

if [ -f ~/.ssh/website_tf.pem ]; then
  echo "You have already created access key."
else
  ssh-keygen -t rsa -b 2048 -f ~/.ssh/website_tf.pem
fi
