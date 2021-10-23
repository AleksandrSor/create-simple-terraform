resource "helm_release" "app" {
  name       = var.app_name
  chart      = "./app"
  namespace  = var.app_name
  create_namespace = true
  depends_on = [
    resource.helm_release.ingress-nginx
  ]
}

data "kubernetes_ingress" "app" {
  metadata {
    name = resource.helm_release.app.name
    namespace = resource.helm_release.app.namespace
  }
}

output "app_ingress" {
  description = "app_ingress"
  value       = data.kubernetes_ingress.app
  sensitive   = true
}


locals {
  app_ingress_status = data.kubernetes_ingress.app.status
  app_ingress_hostname = local.app_ingress_status[0].load_balancer[0].ingress[0].hostname
}

output "app_ingress_status" {
  description = "app_ingress"
  value       = local.app_ingress_status
}

output "app_ingress_hostname" {
  description = "App hostname"
  value       = local.app_ingress_hostname
}

data "http" "app" {
  url = "http://${local.app_ingress_hostname}"
}

output "app_http_response" {
  description = "App http_response"
  value       = data.http.app.body
}

output "app_http_response_valid" {
  description = "Check if response contain valid value"
  value = length(regexall("Hello World", data.http.app.body)) > 0
}