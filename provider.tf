terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.34.1"
    }
    hcp = {
      source = "hashicorp/hcp"
      version = "0.82.0"
    }
  }
}

provider "digitalocean" {
  token = data.hcp_vault_secrets_secret.do_token.secret_value
}

provider "hcp" {
  client_id     = var.HCP_CLIENT_ID
  client_secret = var.HCP_CLIENT_SECRET
}
