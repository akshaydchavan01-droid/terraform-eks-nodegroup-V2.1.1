variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "akshay-cluster_v01"
}

variable "cluster_role_name" {
  description = "IAM role name for the EKS control plane"
  type        = string
  default     = "eks-cluster-example"
}

variable "node_role_name" {
  description = "IAM role name for the EKS worker nodes"
  type        = string
  default     = "eks-node-role"
}

variable "cluster_subnet_ids" {
  description = "Subnet IDs for the EKS control plane"
  type        = list(string)
}

variable "node_subnet_ids" {
  description = "Subnet IDs for the EKS managed node group. Use only subnets with proper outbound connectivity."
  type        = list(string)
}

variable "cluster_security_group_ids" {
  description = "Security group IDs for the EKS cluster"
  type        = list(string)
  default     = []
}

variable "node_group_name" {
  description = "Managed node group name"
  type        = string
  default     = "pc-node-group-v01"
}

variable "instance_types" {
  description = "EC2 instance types for worker nodes"
  type        = list(string)
  default     = ["t3.small"]
}

variable "capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 20
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "environment" {
  description = "Environment label"
  type        = string
  default     = "dev"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the cluster"
  type        = string
  default     = "1.28"
}

variable "cluster_enabled_log_types" {
  description = "List of control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

# NEW: Variables for aws-auth ConfigMap
variable "additional_iam_roles" {
  description = "Additional IAM roles to grant access to the cluster"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "additional_iam_users" {
  description = "Additional IAM users to grant access to the cluster"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}