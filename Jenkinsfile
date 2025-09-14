pipeline {
    agent any

    environment {
        registry = "yourdockerhubusername/yourimagename" // Replace with your Docker Hub username/repo
        registryCredential = 'dockerhub' // This must match the ID of your Jenkins Docker credentials
        dockerImage = ''
    }

    stages {
        stage('Cloning Git') {
            steps {
                // Clone the main branch of your GitHub repo
                git branch: 'main', url: 'https://github.com/swarajtandel/DSO-Lab6.git'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    // Build Docker image using the 'myapp/' folder as context
                    dockerImage = docker.build registry, './myapp'
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    // Trivy security scan for Docker image
                    sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image ${registry}'
                }
            }
        }

        stage('Deploying Image') {
            steps {
                script {
                    // Push Docker image to Docker Hub using Jenkins credentials
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                // Remove local Docker image to free space
                sh "docker rmi ${registry}"
            }
        }
    }

    post {
        always {
            // Clean workspace after every build
            cleanWs()
        }
    }
}
