pipeline {
    agent any

    environment {
        DOCKER_IMAGE_BACKEND  = "saffar29/app-backend:latest"
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
                    docker.image('node:14-alpine').inside {
                        // Use an image with Node.js for the build
                        dir('server') {
                            sh 'ls -la'
                            sh 'npm install'
                            sh 'npm test'
                        }
                    }
                    // Build the Docker image for the backend
                    sh 'docker build -t ${DOCKER_IMAGE_BACKEND} ./server'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                script {
                    docker.image('node:14-alpine').inside {
                        // Use an image with Node.js for the build
                        dir('client') {
                            sh 'ls -la'
                            sh 'npm install'
                            sh 'npm test'
                        }
                    }
                    // Build the Docker image for the frontend
                    sh 'docker build -t ${DOCKER_IMAGE_FRONTEND} ./client'
                }
            }
        }

        stage('Unit Tests') {
            steps {
                script {
                    dir('server') {
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
                sh 'echo "Unit tests passed"'
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/repositories/saffar29', 'docker-credentials-id') {
                        docker.image("${DOCKER_IMAGE_BACKEND}").push()
                        docker.image("${DOCKER_IMAGE_FRONTEND}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deployment steps will go here'
            }
        }
    }

    post {
        always {
            echo 'Performing some actions Als ist gut'
        }
    }
}

