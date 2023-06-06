# Create Bucket
resource "aws_s3_bucket" "name" {
  bucket = "my-birthday-hash-app"
}

# Create Random password
resource "random_password" "password" {
  length           = 16
  special          = true
}

# Create AWS secrets Manager
locals {
  secret_value = {
    username = "api_user"
    password = random_password.password.result
  }
}

resource "aws_secretsmanager_secret" "secret" {
  name = "api/rest-api-secret"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode(local.secret_value)
}

# K8s deployment module
module "deploy" {
  source = "../"

  name = "birthday-hash-app"
  namespace = "hash-app-ns"
  namespace_annotations = {
    "linkerd.io/inject" = "enabled"
  }
  ingress_annotations = {
    "kubernetes.io/ingress.class" =  "nginx"
    "nginx.ingress.kubernetes.io/service-upstream" = "true"
  }
  custom_labels = {
    app = "hash-app"
  }
  image = "raghupal22/hash-app:latest"
  service_port = {
    name        = "http"
    protocol    = "TCP"
    svc_port    = 80
    target_port = 8080
  }
}