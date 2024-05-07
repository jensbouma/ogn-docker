#!/bin/bash
if [ ! -d ./.terraform ]; then
    terraform init
fi

mkdir -p ./tmp
terraform output --raw tf_ansible_vars_file > ./tmp/tf_ansible_vars_file.json
terraform output --raw tf_inventory_file_remote > ./tmp/tf_inventory_file.json

terraform output --raw ogn-config > ./tmp/ogn-config.json
cp ./tmp/ogn-config.json ./rtlsdr-ogn-docker/ogn-config.json

if [ ! -f /opt/homebrew/bin/cloudflared ]; then
    brew install cloudflared
fi

# Insert host and proxycommnad to ssh config
if [ ! -f ~/.ssh/config ]; then
    touch ~/.ssh/config
fi

if ! grep -q "# SSH tunnel configuration for the Raspberry Pi." ~/.ssh/config; then
    terraform output --raw ssh_tunnel_config >> ~/.ssh/config
fi

ansible-playbook -i ./tmp/tf_inventory_file_remote.json -e @./tmp/tf_ansible_vars_file.json ./ansible-playbooks/playbook.yml
