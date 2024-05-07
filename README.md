### Software
- Cloudflared tunnel
- Docker
- Portainer for container management
- Open Glider Network Docker Container

### SaaS/IaaS
- Cloudflare enabled domain name

## Installation
This installation script is configured to add the RPI to a cloudflared tunnel to make the RPI remotly accessable via SSH. To configure local only, remove the tunnel configuration file cloudflare-tunnel.tf, remove the tf_inventory_file_remote output from ansible.tf and remove cloudflared.yml from playbook.yml.

#### Install Ubuntu Server on RPI SD Card
Initalize the SD card with the 'Raspberry Pi Imager' with Ubuntu Server 24.04 LTS from the GUI.

#### Install Ansibible and Terraform (macOS)
```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```

```brew install terraform```

```brew install ansible```

#### Terraform
1. Add the **cloudflare_account_email**, **cloudflare_account_id** & **cloudflare_token** to a terraform.tfvars files or use Terraform cloud to insert variables from variable set.
2. Update locals variable in variables.tf for customizing your setup. 

#### Initialize RPI with local ansible scripton the RPI connected to the local network
1. Make sure to set rpi_ip to the RPI's IP adress in variables.tf
2. ```run.sh```
  
#### Applying (remote) changes to initialized RPI over Cloudflared Tunnel
  ```remote_run.sh```

