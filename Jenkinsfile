pipeline {
agent { label 'docker' }

    environment {
        DOCKER_IMAGE = 'spring-boot-java'
        DOCKER_IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_IMAGE_NAME = "bhargavilakamsani/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                 checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Bhargavi-lakamsani/docker-spring-boot-java-web-service-example.git']])
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG} ."
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'bhargavi-docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                    docker tag ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG} ${DOCKER_IMAGE_NAME}
                    docker push ${DOCKER_IMAGE_NAME}
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE_NAME}"
            }
        }
    }
}
