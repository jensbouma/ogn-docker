locals {
  rpi_user        = "username"          # Username of the Raspberry Pi
  rpi_ip          = "192.168.0.1"       # Local network IP address of the Raspberry Pi
  
  privatekey_file = "~/.ssh/id_rsa"     # Path to the private key file

  receiver_name   = "STATION"           # Please refer to http://wiki.glidernet.org/receiver-naming-convention
  latitude        = "52.06043199236303" # Latitude
  longitude       = "5.938424797261318" # Longitude
  altitude        = "60"                # Altitude in meters

  cloudflare_zone = "yourdomain.com"    # Your domain name in Cloudflare
}

# Cloudflare variables
variable "cloudflare_account_email" {
  type        = string
  description = "Cloudflare Account email"
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_token" {
  type        = string
  sensitive   = true
}
