terraform {
  source = "git::ssh://git@github.com/Ankitchandre/terraform-eks.git//k8s/aws-eks?ref=master"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  worker_groups = [
      {
        instance_type = "t2.large"
        asg_desired_capacity  = 2
        asg_max_size  = 4
        key_name = "idfc-init-pair"
        root_volume_type = "gp2"
        tags = [
          {
          "key"                 = "test-tag"
          "propagate_at_launch" = "false"
          "value"               = "true"
          }
        ]
      }
    ]
  k8s_cluster = {
    region          = "ap-south-1"
    vpc_cidr        = "10.0.0.0/16"
    private_subnets = []
    public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

    project      = "<project-name>"
    environment  = "dev"
    cluster_name = "<cluster-name>"
    k8s_version  = "1.18"
  }
  bastion = {
    enable = false
    trusted_cidrs = ["0.0.0.0/0"]
    key_name = "KEY_PAIR_NAME_THAT_ALREADY_EXISTS"
    instance_type = "t2.micro"
  }
}
