#!/bin/bash
yum update -y

#SSH設定
cat << EOF >> /home/ssm-user/.ssh/config
# SSH over Session Manager
host i-* mi-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
