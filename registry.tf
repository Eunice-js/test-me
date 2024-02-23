resource "digitalocean_container_registry" "image_registry" {
  name = "image-registry-${var.env}"
  region = var.region
  subscription_tier_slug = "starter"
}

resource "digitalocean_container_registry_docker_credentials" "image_registry" {
  depends_on = [
    digitalocean_container_registry.image_registry
  ]
  registry_name = "image-registry-${var.env}"
  write = true
}

resource "hcp_vault_secrets_secret" "registry_credentials" {
  depends_on = [
    digitalocean_container_registry_docker_credentials.image_registry
  ]
  app_name     = "terraform-infra-dev"
  secret_name = "IMAGE_REGISTRY_CREDENTIALS"
  secret_value = digitalocean_container_registry_docker_credentials.image_registry.docker_credentials
}

