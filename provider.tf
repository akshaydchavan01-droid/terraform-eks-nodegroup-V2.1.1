terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # NEW: Add Kubernetes provider for aws-auth ConfigMap
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }

  backend "s3" {
    bucket         = "our-terraform-tfstate-file-bucket-6150"
    key            = "Server-terraform"
    region         = "ap-south-1"
    dynamodb_table = "my-dynamo-db-practice-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# NEW: Kubernetes provider configuration
provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the aws-cli to be installed in your Jenkins agent!
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.this.name, "--region", var.aws_region]
  }
}

# NEW: Get authentication token for Kubernetes provider
data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.this.name
}
