pipeline {
    agent any

    environment {
        registry = "swarajtandel/myapp-node"  // your Docker Hub username/image
        registryCredential = 'dockerhub'      // matches Jenkins credentials ID
        dockerImage = ''
    }

    stages {
        stage('Cloning Git') {
            steps {
                git 'https://github.com/swarajtandel/DSO-Lab6.git'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    // Build using Dockerfile inside 'myapp/' folder
                    dockerImage = docker.build registry, './myapp'
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    // Run Trivy scan on the built image
                    sh 'docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image ${registry}'
                }
            }
        }

        stage('Deploying Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                sh "docker rmi ${registry}"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
