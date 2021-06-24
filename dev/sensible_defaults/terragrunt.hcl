terraform {
  source = "git::ssh://git@github.com/Ankitchandre/terraform-eks.git//k8s/sensible_defaults?ref=master"
}

include {
  path = find_in_parent_folders()
}

dependency "k8s" {
  config_path = "../k8s"

  mock_outputs = {
    kubeconfig_path = "~/.kube/config"
    cloud_provider = "dummy-cloud_provider"
    region = "dummy-region"
    cluster_name = "dummy-cluster-name"
    cluster_autoscaler_role_arn = "dummy-autoscaler-role-arn"
  }
}

inputs = {
  kubeconfig_path = dependency.k8s.outputs.kubeconfig_path
  cloud_provider = dependency.k8s.outputs.cloud_provider
  region = dependency.k8s.outputs.region
  cluster_name = dependency.k8s.outputs.cluster_name
  cluster_autoscaler_role_arn = dependency.k8s.outputs.cluster_autoscaler_role_arn

  install_ci = false
  install_nginx = true
  install_cluster_autoscaler_aws = true
  install_loki = false
  install_prometheus = false
  grafana_admin_password = "admin"
  jenkins_admin_password = "admin"
  linkerd_validity_hours = 87600
  linkerd_common_name = "identity.linkerd.cluster.local"
  linkerd_organization = "<org name>"
}
