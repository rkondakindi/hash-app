output "namespace_id" {
  value = kubernetes_namespace.namespace.id
}

output "service_port" {
  value = kubernetes_service.service.spec[0]
}