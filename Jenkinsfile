pipeline {
    agent any

    environment {
        DOCKER_IMAGE_BACKEND  = "saffar29/server:latest"
        DOCKER_IMAGE_FRONTEND = "saffar29/client:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    dir('server') {
                        sh 'docker build -t ${DOCKER_IMAGE_BACKEND} .'
                    }
                }
            }
        }

        stage('Build Frontend') {
            steps {
                script {
                    dir('client') {
                        sh 'docker build -t ${DOCKER_IMAGE_FRONTEND} .'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'saffar29') {
                        docker.image("${DOCKER_IMAGE_BACKEND}").push()
                        docker.image("${DOCKER_IMAGE_FRONTEND}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deployment steps will go here'
                // Add deployment steps if needed
            }
        }
    }

    post {
        always {
            echo 'Performing some actions, all is well'
        }
    }
}
