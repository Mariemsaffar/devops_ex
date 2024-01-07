pipeline {
    agent any

    environment {
        // Define environment variables, Docker registry, etc.
        DOCKER_IMAGE_BACKEND  = "saffar29/mongodb_back:latest"
        DOCKER_IMAGE_FRONTEND = "saffar29/client:latest"
        // Add more environment variables if needed
    }

    stages {
        stage('Initialization') {
            steps {
                script {
                    // Initialize global variables or perform any setup steps here
                    // For example, you might want to clean up existing containers or volumes
                    sh 'docker-compose down -v'
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    dir('server') {
                        // Build backend image
                        sh 'docker build -t saffar29/mongodb_back:latest .'
                    }
                }
            }
        }

        stage('Build Frontend') {
            steps {
                script {
                    dir('client') {
                        // Build frontend image
                        sh 'docker build -t saffar29/client:latest .'
                    }
                }
            }
        }

        stage('Unit Tests') {
            steps {
                script {
                    dir('server') {
                       // Install backend dependencies and run tests
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
                    // Push backend image to registry
                    docker.withRegistry('https://registry.hub.docker.com', 'saffar29') {
                        docker.image("${DOCKER_IMAGE_BACKEND}").push()
                    }

                    // Push frontend image to registry
                    docker.withRegistry('https://registry.hub.docker.com', 'saffar29') {
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
            echo 'Cleaning up...'
            // Perform any necessary cleanup steps here
            sh 'docker-compose down -v'
        }
    }
}
