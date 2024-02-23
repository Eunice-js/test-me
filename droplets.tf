# Create the droplet resource that will host the frontend and backend applications.
resource "digitalocean_droplet" "web" {
  depends_on = [
    digitalocean_container_registry.image_registry,
    digitalocean_container_registry_docker_credentials.image_registry
  ]
  image  = "ubuntu-22-04-x64"
  name   = "app-${var.env}"
  region = var.region
  size = var.size_1_2gb
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      # Update the package list
      "apt-get update -y",
      "apt install apt-transport-https ca-certificates curl software-properties-common -y",
      # Add the docker repository
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -",
      "add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable' -y",
      "apt-cache policy docker-ce",
      # Install docker
      "apt install docker-ce -y",
      # Create and add the user to the docker group
      "useradd -m ${var.user}",
      "usermod -aG docker ${var.user}",
      # Switch to the user
      "su ${var.user}",
      "export CRED_JSON_CONTENT=$(echo '${hcp_vault_secrets_secret.registry_credentials.secret_value}' | jq -c .)",
      "echo $CRED_JSON_CONTENT > ~/${var.user}/config.json",
    ]
  }
}
