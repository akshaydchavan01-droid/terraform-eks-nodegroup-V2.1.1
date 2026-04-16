aws_region         = "ap-south-1"
vpc_id             = "vpc-02db77e71cf468080"
cluster_name       = "akshay-cluster-v01"
cluster_subnet_ids = ["subnet-0c83a981ba5037a57", "subnet-0571a9d8fff598207"]
node_subnet_ids    = ["subnet-0c83a981ba5037a57", "subnet-0571a9d8fff598207"]
node_group_name    = "pc-node-group-v01"
instance_types     = ["t3.small"]
desired_size       = 2
min_size           = 1
max_size           = 4
environment        = "dev"
kubernetes_version = "1.32"

# RBAC Configuration - Add your IAM user/role for access
additional_iam_users = [
  {
    userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/devops-admin"
    username = "devops-admin"
    groups   = ["system:masters"]
  }
]

additional_iam_roles = [
  # Add additional roles if needed
]

tags = {
  Terraform   = "true"
  Environment = "dev"
  Project     = "EKS"
}
