# Namespace
resource "kubernetes_namespace" "namespace" {
  metadata {
    name        = var.namespace
    annotations = var.namespace_annotations
    labels      = local.labels
  }
}

# Deployment
resource "kubernetes_deployment" "deployment" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    labels      = local.labels
    annotations = var.deployment_annotations
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = local.labels
    }

    template {
      metadata {
        labels      = local.labels
        annotations = var.template_annotations
      }

      spec {
        container {
          name    = var.container_name
          image   = var.image
          args    = var.args
          command = var.command

          dynamic "resources" {
            for_each = length(var.resources) == 0 ? [] : [{}]
            content {
              requests = {
                cpu    = lookup(var.resources, "request_cpu", null)
                memory = lookup(var.resources, "request_memory", null)
              }
              limits = {
                cpu    = lookup(var.resources, "limit_cpu", null)
                memory = lookup(var.resources, "limit_memory", null)
              }
            }
          }

          dynamic "port" {
            for_each = var.internal_port
            content {
              container_port = port.value.internal_port
              name           = substr(port.value.name, 0, 14)
              host_port      = lookup(port.value, "host_port", null)
            }
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service" "service" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }
  spec {
    selector = local.labels
    # session_affinity = "ClientIP"
    dynamic "port" {
      for_each = length(var.service_port) == 0 ? [] : [{}]
      content {
        name        = lookup(var.service_port, "name", null)
        protocol    = lookup(var.service_port, "protocol", null)
        target_port = lookup(var.service_port, "target_port", null)
        port        = lookup(var.service_port, "svc_port", null)
      }
    }

    type = var.service_type
  }
}

# Ingress
resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = var.ingress_annotations
  }

  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service.service.metadata.0.name
              port {
                number = lookup(var.service_port, "svc_port", null)
              }
            }
          }
        }
      }
    }
  }
}
