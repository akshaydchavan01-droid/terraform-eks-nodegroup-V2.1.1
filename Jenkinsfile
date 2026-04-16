pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Select the action to perform'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/akshaydchavan01-droid/terraform-eks-nodegroup-V2.1.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -reconfigure'
            }
        }

        // ✅ ADD THIS STAGE HERE
        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -recursive'
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.ACTION == 'destroy') {
                        sh 'terraform plan -destroy -out=tfplan-destroy'
                    } else {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply / Destroy') {
            steps {
                script {
                    if (params.ACTION == 'destroy') {
                        echo 'Executing Destroy...'
                        sh 'terraform apply -auto-approve tfplan-destroy'
                    } else {
                        echo 'Executing Apply...'
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }
}
