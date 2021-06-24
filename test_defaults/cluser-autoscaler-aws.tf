resource "helm_release" "cluster-autoscaler" {
  count      = var.cloud_provider == "aws" ? 1 : 0
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  timeout    = 300
  version    = "9.3.0"

  values = [templatefile("${path.root}/cluster-autoscaler-aws-values.tpl", {
    region                      = var.region
    cluster_name                = var.cluster_name,
    cluster_autoscaler_role_arn = var.cluster_autoscaler_role_arn,
  })]
}
