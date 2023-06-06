## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.deployment](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_ingress_v1.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_args"></a> [args](#input\_args) | (Optional) Arguments to the entrypoint | `list(string)` | `[]` | no |
| <a name="input_command"></a> [command](#input\_command) | (Optional) Entrypoint array | `list(string)` | `[]` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Container name | `string` | `"container1"` | no |
| <a name="input_custom_labels"></a> [custom\_labels](#input\_custom\_labels) | (Optional) Add custom label to pods | `map(string)` | `null` | no |
| <a name="input_deployment_annotations"></a> [deployment\_annotations](#input\_deployment\_annotations) | Annotations for deployment | `map(string)` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | (Required) Docker image name | `string` | n/a | yes |
| <a name="input_ingress_annotations"></a> [ingress\_annotations](#input\_ingress\_annotations) | Annotations for Ingress | `map(string)` | `null` | no |
| <a name="input_internal_port"></a> [internal\_port](#input\_internal\_port) | (Optional) List of ports to expose from the container | <pre>list(object({<br>    name          = string<br>    internal_port = number<br>    host_port     = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | App name. same used for service | `string` | `"my-test-app"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Enter your namespace | `string` | `"default"` | no |
| <a name="input_namespace_annotations"></a> [namespace\_annotations](#input\_namespace\_annotations) | Annotations for Namespace | `map(string)` | `null` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | No of replicas | `number` | `1` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | (Optional) Compute Resources required by this container. CPU/RAM requests/limits | `map` | `{}` | no |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Service Ports | <pre>object({<br>    name        = optional(string)<br>    protocol    = optional(string)<br>    svc_port    = number<br>    target_port = number<br>  })</pre> | n/a | yes |
| <a name="input_service_type"></a> [service\_type](#input\_service\_type) | Service Type. Allowed Values: ClusterIP/NodePort/LoadBalancer/ExternalName | `string` | `"ClusterIP"` | no |
| <a name="input_template_annotations"></a> [template\_annotations](#input\_template\_annotations) | Annotations for pod (template) | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | n/a |
| <a name="output_service_port"></a> [service\_port](#output\_service\_port) | n/a |
