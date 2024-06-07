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

        stage('Deploy') {
            steps {
                sshagent(['k8s']) {
                    // Transfer YAML files to the remote machine
                    sh 'scp -o StrictHostKeyChecking=no deployment.yaml service.yaml ubuntu@13.201.8.113:/home/ubuntu/kubernetes-installation-microk8s
'
                    
                    script {
                        try {
                            // Apply Kubernetes configurations
                            sh 'ssh ubuntu@13.201.8.113 kubectl apply -f /home/ubuntu/kubernetes-installation-microk8s'
'
                            sh 'ssh ubuntu@13.201.8.113 kubectl apply -f /home/ubuntu/kubernetes-installation-microk8s'
'
                        } catch (error) {
                            // Fallback to create if apply fails
                            sh 'ssh ubuntu@13.201.8.113 kubectl create -f /home/ubuntu/kubernetes-installation-microk8s'
'
                            sh 'ssh ubuntu@13.201.8.113 kubectl create -f /home/ubuntu/kubernetes-installation-microk8s'

                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
