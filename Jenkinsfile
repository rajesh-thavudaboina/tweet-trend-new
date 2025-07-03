pipeline {
    agent {
        node {
            label "maven"
        }
    }

    environment {
        PATH = "/opt/apache-maven-3.9.10/bin:$PATH"
        IMAGE_NAME = "rajeshthavudaboina/ttrend"
        IMAGE_TAG = "2.1.3"
    }

    stages {
        stage('Build with Maven') {
            steps {
                sh 'mvn clean deploy'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Docker Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-hub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push $IMAGE_NAME:$IMAGE_TAG
                        docker logout
                    '''
                }
            }
        }
        stage ("deploy"){
            steps{
                script{
                    sh "chmod 0755 deploy.sh"
                    sh "./deploy.sh"
                }
            }
        }
    }
}
