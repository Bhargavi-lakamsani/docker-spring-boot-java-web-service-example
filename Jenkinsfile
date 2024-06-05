pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'bhargavilakamsani/javaapp:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Bhargavi-lakamsani/docker-spring-boot-java-web-service-example.git']])
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE_NAME .'
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'bhargavi-docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_IMAGE_NAME
                    '''
                }
            }
        }

        stage('Install kubectl') {
            steps {
                sh '''
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                chmod +x kubectl
                sudo mv kubectl /usr/local/bin/
                '''
            }
        }

        stage('Deploy') {
            steps {
                // Moving the file to a directory where jenkins has permissions
                sh 'mkdir -p /var/lib/jenkins/workspace/kubernetes-microk8s'
                sh 'mv /var/lib/jenkins/workspace/kubernetes/deployment.yaml /var/lib/jenkins/workspace/kubernetes-microk8s/deployment.yaml'
                sh 'mv /var/lib/jenkins/workspace/kubernetes/service.yaml /var/lib/jenkins/workspace/kubernetes-microk8s/service.yaml'
                sh 'kubectl apply -f /var/lib/jenkins/workspace/kubernetes-microk8s/deployment.yaml'
                sh 'kubectl apply -f /var/lib/jenkins/workspace/kubernetes-microk8s/service.yaml'
            }
        }
    }
}
