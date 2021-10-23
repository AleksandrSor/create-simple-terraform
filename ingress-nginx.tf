locals {
  ingress_name = "ingress-nginx"
}

resource "helm_release" "ingress-nginx" {
  name       = local.ingress_name
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = local.ingress_name
  create_namespace = true
  depends_on = [
    module.eks.cluster_ids
  ]
}

data "kubernetes_ingress" "ingress-nginx" {
  metadata {
    name = resource.helm_release.ingress-nginx.name
    namespace = resource.helm_release.ingress-nginx.namespace
  }
}

output "ingress_nginx" {
  description = "Ingress Controller"
  value = data.kubernetes_ingress.ingress-nginx
  sensitive = true
}

output "ingress_controller_status" {
  description = "Ingress Controller"
  value = data.kubernetes_ingress.ingress-nginx.status
}