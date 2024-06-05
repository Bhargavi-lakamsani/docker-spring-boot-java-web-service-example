pipeline {
     agent { label 'docker' }
    
    environment {
        DOCKER_CREDENTIALS = credentials("bhargavi-docker")
        DOCKER_IMAGE_NAME = 'bhargavilakamsani/javaapp'
        DOCKER_IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
               checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Bhargavi-lakamsani/docker-spring-boot-java-web-service-example.git']])
            }
        }
        
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG .'
            }
        }
        
        stage('Push') {
            steps {
                  sh "$DOCKER_CREDENTIALS
                sh "docker push $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
            }
        }
        
        stage('Deploy') {
            steps {
                
              
            }
        }
    }
}

