#!/bin/bash
if [ ! -d ./.terraform ]; then
    terraform init
fi

terraform apply -auto-approve
mkdir -p ./tmp
terraform output --raw tf_ansible_vars_file > ./tmp/tf_ansible_vars_file.json
terraform output --raw tf_inventory_file_local > ./tmp/tf_inventory_file.json

terraform output --raw ogn-config > ./tmp/ogn-config.json

ansible-playbook -i ./tmp/tf_inventory_file.json -e @./tmp/tf_ansible_vars_file.json ./ansible-playbooks/playbook.yml