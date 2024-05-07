terraform {
  cloud {
    organization = "jensbouma"
    workspaces {
      name = "ehtl_receiver_thermiekbel"
    }
  }
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    google = {
      source = "hashicorp/google"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}

provider "cloudflare" {
  api_key = var.cloudflare_token
  email   = var.cloudflare_account_email
}
provider "random" {
}