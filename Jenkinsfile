pipeline {
    agent { label 'build-agent' }

    environment {
        AWS_REGION = 'us-east-1' 
        ECR_REPO = '911167886485.dkr.ecr.us-east-1.amazonaws.com/abdul-ops' 
        IMAGE_NAME = 'docker-image'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/abdullasd14301/ops-abdul.git'
            }
        }

        stage('Build Java Application') {
            steps {
                sh 'mvn clean package -DskipTests' 
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "sudo docker build -t abdul-ops ."
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                script {
                    // Log in to AWS ECR
                    sh """
                    aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 911167886485.dkr.ecr.us-east-1.amazonaws.com
                    """

                    // Tag the Docker image
                    sh "sudo docker tag abdul-ops:latest 911167886485.dkr.ecr.us-east-1.amazonaws.com/abdul-ops:latest"

                    // Push the Docker image to ECR
                    sh "sudo docker push 911167886485.dkr.ecr.us-east-1.amazonaws.com/abdul-ops:latest"
                }
            }
        }
    }
}
