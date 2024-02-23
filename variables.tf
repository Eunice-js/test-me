variable "env" {
  type = string
  description = "Infrastructure environment"
  default = "dev"
}

variable "pvt_key" {
  type = string
  description = "Digital ocean droplet ssh private key file name"
  default = "terraform.pem"
}
variable "region" {
  type = string
  description = "Infrastructure region"
  default = "fra1"
}

variable "size_1_1gb" {
  type = string
  description = "Size of the droplet"
  default = "s-1vcpu-1gb"
}

variable "size_1_2gb" {
    type = string
    description = "Size of the droplet"
    default = "s-1vcpu-2gb"
}

variable "user" {
  type = string
  description = "User to be added to the docker group"
  default = "web"
}

variable "HCP_CLIENT_ID" {
  description = "HashiCorp Cloud Platform client ID"
  default     = ""
}

variable "HCP_CLIENT_SECRET" {
  description = "HashiCorp Cloud Platform client secret"
  default     = ""
}

