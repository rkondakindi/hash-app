variable "namespace" {
  description = "Enter your namespace"
  type        = string
  default     = "default"
}

variable "namespace_annotations" {
  description = "Annotations for Namespace"
  type        = map(string)
  default     = null
}

variable "name" {
  description = "App name. same used for service"
  type        = string
  default     = "my-test-app"
}

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "container1"
}

variable "replicas" {
  description = "No of replicas"
  type        = number
  default     = 1
}

variable "custom_labels" {
  description = "(Optional) Add custom label to pods"
  type        = map(string)
  default     = null
}

variable "deployment_annotations" {
  description = "Annotations for deployment"
  type        = map(string)
  default     = null
}

variable "template_annotations" {
  description = "Annotations for pod (template)"
  type        = map(string)
  default     = null
}

variable "image" {
  description = "(Required) Docker image name"
  type        = string
}

variable "args" {
  description = "(Optional) Arguments to the entrypoint"
  type        = list(string)
  default     = []
}

variable "command" {
  type        = list(string)
  description = "(Optional) Entrypoint array"
  default     = []
}

variable "resources" {
  description = "(Optional) Compute Resources required by this container. CPU/RAM requests/limits"
  /*  type = object({
    request_cpu    = optional(string)
    request_memory = optional(string)
    limit_cpu      = optional(string)
    limit_memory   = optional(string)
  })*/
  default = {}
}

variable "internal_port" {
  description = "(Optional) List of ports to expose from the container"
  type = list(object({
    name          = string
    internal_port = number
    host_port     = optional(string)
  }))
  default = []
}

variable "service_port" {
  description = "Service Ports"
  type = object({
    name        = optional(string)
    protocol    = optional(string)
    svc_port    = number
    target_port = number
  })
  # default = {}
}

variable "service_type" {
  description = "Service Type. Allowed Values: ClusterIP/NodePort/LoadBalancer/ExternalName "
  type        = string
  default     = "ClusterIP"
}

variable "ingress_annotations" {
  description = "Annotations for Ingress"
  type        = map(string)
  default     = null
}