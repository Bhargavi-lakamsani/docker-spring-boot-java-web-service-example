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

        stage('deploy') {
            steps {
                sshagent(['k8s']) {
                 sh "scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/k8s-java/*.yaml ubuntu@13.201.8.113:/home/ubuntu"
                    script{
                        try{ 
                            sh "ssh ubuntu@13.201.8.113 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ubuntu@13.201.8.113 kubectl create -f ."
            
                               }
                             }
                           }
                        }
                     }
                 }
               }

