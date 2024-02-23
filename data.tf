# get the ssh key id from the digitalocean
data "digitalocean_ssh_key" "terraform" {
  name = "terraform"
}

# Get the digitalocean token and private key from the vault
data "hcp_vault_secrets_secret" "do_token" {
  app_name = "testing-app"
  secret_name = "DIGITALOCEAN_TOKEN"
}
