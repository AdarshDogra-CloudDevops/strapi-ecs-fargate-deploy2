variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name prefix for resources"
  default     = "strapi-ecs"
}
variable "app_keys" {}
variable "api_token_salt" {}
variable "admin_jwt_secret" {}
variable "transfer_token_salt" {}
variable "encryption_key" {}
variable "jwt_secret" {}
variable "database_client" {
  default = "sqlite"
}
variable "database_filename" {
  default = ".tmp/data.db"
}
variable "host" {
  default = "0.0.0.0"
}
variable "port" {
  default = "1337"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag to deploy (e.g. Git SHA)"
}
