resource "helm_release" "nginx" {
  count      = var.install_nginx ? 1 : 0
  name       = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "default"
  timeout    = 300
}
