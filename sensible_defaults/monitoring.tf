resource "kubernetes_namespace" "monitoring" {
  count = var.install_prometheus ? 1 : 0
  timeouts {
    delete = "10m"
  }

  metadata {
    annotations = {
      name = "monitoring"
    }
    name = "monitoring"
  }
}

resource "helm_release" "monitoring" {
  count      = var.install_prometheus ? 1 : 0
  depends_on = [kubernetes_namespace.monitoring]
  name       = "prometheus"
  chart      = "stable/prometheus-operator"
  namespace  = kubernetes_namespace.monitoring[0].metadata[0].name

  set_sensitive {
    name  = "grafana.adminPassword"
    value = var.grafana_admin_password
  }
}

resource "helm_release" "metrics-server" {
  name      = "metrics-server"
  chart     = "stable/metrics-server"
  namespace = "kube-system"

  set {
    name  = "args"
    value = "{--kubelet-insecure-tls=true,--kubelet-preferred-address-types=InternalIP}"
  }
}
