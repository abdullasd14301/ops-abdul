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
                sh "sudo docker build -t $IMAGE_NAME ."
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                script {
                    // Log in to AWS ECR
                    sh """
                    aws ecr get-login-password --region $AWS_REGION | sudo docker login --username AWS --password-stdin $ECR_REPO
                    """

                    // Tag the Docker image
                    sh "sudo docker tag $IMAGE_NAME:latest $ECR_REPO:latest"

                    // Push the Docker image to ECR
                    sh "sudo docker push $ECR_REPO:latest"
                }
            }
        }
    }
}
