pipeline {
    agent any

    environment {
        registry = "swarajtandel/myapp" // your Docker Hub repo
        registryCredential = 'dockerhub' // Jenkins credentials ID
        dockerImage = ''
    }

    stages {
        stage('Cloning Git') {
            steps {
                git branch: 'main', url: 'https://github.com/swarajtandel/DSO-Lab6.git'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    // Dockerfile is now in root
                    dockerImage = docker.build registry, './myapp'
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
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
