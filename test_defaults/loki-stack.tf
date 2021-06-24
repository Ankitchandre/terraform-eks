resource "kubernetes_namespace" "logging" {
  count = var.install_loki ? 1 : 0
  timeouts {
    delete = "10m"
  }

  metadata {
    annotations = {
      name = "logging"
    }
    name = "logging"
  }
}

resource "helm_release" "loki-stack" {
  count      = var.install_loki ? 1 : 0
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  namespace  = kubernetes_namespace.logging[0].metadata[0].name
  name       = "loki-stack"
  timeout    = 300

  values = [file("${path.root}/loki-stack-values.yaml")]
}