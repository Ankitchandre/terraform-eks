awsRegion: ${region}

rbac:
  create: true
  serviceAccount:
    # This value should match local.k8s_service_account_name in locals.tf
    name: cluster-autoscaler
    annotations:
      # This value should match the ARN of the role created by module.iam_assumable_role_admin in irsa.tf
      eks.amazonaws.com/role-arn: ${cluster_autoscaler_role_arn}

autoDiscovery:
  clusterName: ${cluster_name}
  enabled: true

extraArgs:
  scale-down-enabled: true