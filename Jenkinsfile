pipeline {
    agent any

    environment {
        // Define environment variables, Docker registry, etc.
        DOCKER_IMAGE_BACKEND  = "saffar29/server:latest"
        DOCKER_IMAGE_FRONTEND = "saffar29/client:latest"
        // More environment variables can be added here
    }

    stages {
        stage('Checkout') {
            steps {
                // Get the latest code from your source control
                checkout scm
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    dir('server') {
                        sh 'ls -la' // Lists all files in the server directory
                        sh 'docker build -t saffar29/server .'
                    }
                }
            }
        }


        stage('Build Frontend') {
            steps {
                script {
                    dir('client') {
                        sh 'ls -la' // Lists all files in the server directory
                        sh 'docker build -t saffar29/client .'
                    }
                }
            }
        }


        stage('Unit Tests') {
            steps {
                // script {
                //     dir('client') {
                //        sh 'ls -la' // Lists all files in the server directory
                //        sh 'npm test'
                //     }
                // }

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
                    // Login to Docker Hub and push the images
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
            }
        }
    }

    post {
        always {
            echo 'Performing some actions Als ist gut'
        }
    }
}
