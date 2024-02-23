resource "digitalocean_database_cluster" "postgres" {
  name = "postgres-${var.env}"
  engine = "pg"
  version = "16"
  node_count = 1
  region     = var.region
  size       = "db-${var.size_1_1gb}"
}

resource "digitalocean_database_cluster" "redis" {
  name = "redis-${var.env}"
  engine     = "redis"
  version    = "7"
  node_count = 1
  region     = var.region
  size       = "db-${var.size_1_1gb}"
}

resource "hcp_vault_secrets_secret" "db_uri" {
  depends_on = [
    digitalocean_database_cluster.postgres
  ]
  app_name     = "terraform-infra-dev"
  secret_name  = "DB_URI"
  secret_value = digitalocean_database_cluster.postgres.private_uri
}

resource "hcp_vault_secrets_secret" "redis_uri" {
  depends_on = [
    digitalocean_database_cluster.redis
  ]
  app_name     = "terraform-infra-dev"
  secret_name  = "REDIS_URI"
  secret_value = digitalocean_database_cluster.redis.private_uri
}
